import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smart_ai/data/data_source/local/auth_local_source.dart';
import 'package:smart_ai/model/user_model.dart';
import 'package:smart_ai/utils/helpers/format_helpers.dart';

import '../../model/sign_up_model.dart';
import '../data_source/remote/auth_remote_source.dart';

class AuthRepo {
  AuthLocalSource authLocalSource;
  AuthRemoteSource authRemoteSource;

  AuthRepo({
    required this.authLocalSource,
    required this.authRemoteSource,
  });

  final FirebaseAuth auth = FirebaseAuth.instance;
  int? resendToken;
  String verificationId = '';

  Future verifyPhoneNumber(
    String phoneNumber,
    Function(UserCredential?, String?) onVerificationCompleted, {
    bool resendCode = false,
  }) {
    return auth.verifyPhoneNumber(
      phoneNumber: FormatHelpers.phoneNumber(phoneNumber),
      timeout: const Duration(seconds: 60),
      forceResendingToken: resendCode ? resendToken : null,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        onVerificationCompleted(userCredential, null);
      },
      verificationFailed: (FirebaseAuthException err) {
        String? errMsg;
        if (err.code == 'invalid-phone-number') {
          errMsg = 'phone_not_valid'.tr;
        } else if (err.code == 'too-many-requests') {
          errMsg = 'too_many_attempts'.tr;
        } else {
          errMsg = err.message;
        }
        if (kDebugMode) {
          print(err.toString());
        }
        onVerificationCompleted(null, errMsg);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        this.resendToken = resendToken;
        onVerificationCompleted(null, null);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Verify otp code sent
  Future<UserCredential> verifyOTP(String otp) {
    if (verificationId.isEmpty) {
      debugPrint('>>> Verify otp with verificationId empty');
      return Future.error('Something went wrong.');
    }
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    return auth.signInWithCredential(credential);
  }

  Future<UserModel> updateNewPassword(String phone, String newPassword) async {
    try {
      var userModelResponse =
          await authRemoteSource.forgotPassword(phone, newPassword);
      if (userModelResponse.success && userModelResponse.data != null) {
        await authLocalSource.saveAccessToken(userModelResponse.token);
        UserModel userModel = userModelResponse.data!;
        return userModel;
      }
      return Future.error(userModelResponse.message);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<String> changePassword(
      String phone, String currentPassword, String newPassword) async {
    try {
      var response = await authRemoteSource.changePassword(
          phone, currentPassword, newPassword);
      if (response.success) {
        return response.message;
      }
      return Future.error(response.message);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future signOut() async {
    verificationId = '';
    resendToken = null;
    await auth.signOut();
  }

  void saveRememberMe(bool isRememberMe) {
    authLocalSource.saveRememberMe(isRememberMe);
  }

  bool getRememberMe() {
    return authLocalSource.getRememberMe();
  }

  Future savePhoneNumberPassword(String phone, String password) async {
    await authLocalSource.savePhoneNumberPassword(phone, password);
  }

  String getRememberPhone() {
    return authLocalSource.getRememberPhone();
  }

  String getRememberPassword() {
    return authLocalSource.getRememberPassword();
  }

  Future<UserModel> signIn(String phone, String password) async {
    try {
      var userModelResponse = await authRemoteSource.signIn(phone, password);
      if (userModelResponse.success && userModelResponse.data != null) {
        await authLocalSource.saveAccessToken(userModelResponse.token);
        UserModel userModel = userModelResponse.data!;
        return userModel;
      }
      return Future.error(userModelResponse.message);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<UserModel> signUp(SignUpModel signUpModel) async {
    try {
      var userModelResponse = await authRemoteSource.signUp(signUpModel);
      if (userModelResponse.success && userModelResponse.data != null) {
        await authLocalSource.saveAccessToken(userModelResponse.token);
        UserModel userModel = userModelResponse.data!;
        return userModel;
      }
      return Future.error(userModelResponse.message);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<bool> checkPhoneExisted(String phone) async {
    try {
      var response = await authRemoteSource.checkPhoneExisted(phone);
      if (response.success && response.data != null) {
        return response.data ?? false;
      }
      return Future.error(response.message);
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<bool> saveUserLocal(UserModel userModel) async {
    return await authLocalSource.saveUserLocal(userModel);
  }

  UserModel? getUserLocal() {
    try {
      var userModel = authLocalSource.getUserLocal();
      return userModel;
    } catch (e) {
      debugPrint('>>> Get user local: $e');
      return null;
    }
  }

  Future<bool> deleteUserLocal() async {
    return await authLocalSource.deleteUserLocal();
  }
}
