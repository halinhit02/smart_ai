import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:smart_ai/data/repository/auth_repo.dart';
import 'package:smart_ai/model/sign_up_model.dart';
import 'package:smart_ai/model/user_model.dart';
import 'package:smart_ai/utils/constants/app_routes.dart';
import 'package:smart_ai/utils/constants/dimensions.dart';
import 'package:smart_ai/utils/helpers/dialog_helpers.dart';
import 'package:smart_ai/utils/helpers/format_helpers.dart';

import '../data/repository/user_repo.dart';
import '../utils/constants/images.dart';

class AuthController extends GetxController {
  AuthRepo authRepo;
  UserRepo userRepo;

  AuthController({
    required this.authRepo,
    required this.userRepo,
  });

  RxBool agreePolicy = true.obs;
  RxBool verifyLoading = false.obs;
  RxBool verifyOtpLoading = false.obs;
  RxBool rememberMe = false.obs;
  RxBool updatingUser = false.obs;
  RxBool saveLoading = false.obs;

  String _phoneNumber = '';
  String _password = '';
  final Rx<UserModel?> _userModel = Rx(null);

  Rx<UserModel?> get userModel => _userModel;

  String get phoneNumber => _phoneNumber;

  String get password => _password;

  User? get currentUser => authRepo.auth.currentUser;

  @override
  void onInit() {
    super.onInit();
    getUserLocal();
    _getRememberPhonePassword();
    _rememberMeKeyListener();
  }

  void getUserLocal() {
    _userModel.value = authRepo.getUserLocal();
  }

  Future signIn(String phone, String password) async {
    if (!_checkPhoneInput(phone) || !_checkPasswordInput(password)) {
      return;
    }
    verifyLoading.value = true;
    _phoneNumber = phone;
    _password = password;
    try {
      if (rememberMe.isTrue) {
        authRepo.savePhoneNumberPassword(phone, password);
      } else {
        authRepo.savePhoneNumberPassword('', '');
      }
      var userModel = await authRepo.signIn(_phoneNumber, password);
      await authRepo.saveUserLocal(userModel);
      // update user model in user controller
      DialogHelpers.showMessage('Hi ${userModel.fullName}, welcome to my app.');
      _password = '';
      verifyLoading.value = false;
      Get.offAllNamed(AppRoutes.homeRoute);
    } catch (err) {
      verifyLoading.value = false;
      DialogHelpers.showErrorMessage(err.toString());
    }
  }

  Future signUp(String phone, String password, String rePassword) async {
    if (!_checkPhoneInput(phone) ||
        !_checkPasswordInput(password, rePassword)) {
      return;
    }
    if (agreePolicy.isFalse) {
      DialogHelpers.showMessage('Agree to SmartAI policy.', error: true);
      return;
    }
    verifyLoading.value = true;
    _phoneNumber = phone;
    _password = password;
    // Check phone existed
    bool phoneExisted = await authRepo.checkPhoneExisted(phone);
    if (phoneExisted) {
      verifyLoading.value = false;
      DialogHelpers.showMessage('Phone is existed.', error: true);
      return;
    }
    // Data is valid
    await verifyPhone(
      phone,
      redirectRoute: AppRoutes.otpVerificationRoute(
        AppRoutes.completeProfile,
      ),
    );
  }

  Future createUser(SignUpModel signUpModel) async {
    try {
      if (!_checkProfileData(signUpModel)) {
        return;
      }
      signUpModel.phone = _phoneNumber;
      signUpModel.password = _password;
      saveLoading.value = true;
      _userModel.value = await authRepo.signUp(signUpModel);
      await authRepo.saveUserLocal(_userModel.value!);
      if (rememberMe.isFalse) {
        _phoneNumber = '';
        _password = '';
      }
      await Future.delayed(const Duration(milliseconds: 300));
      DialogHelpers.showMessage('Your account is created successfully.');
      Get.offAllNamed(AppRoutes.welcomeRoute);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('>>> Create user model exception: $e');
      }
      DialogHelpers.showErrorMessage('Sign up failed.');
    }
    saveLoading.value = false;
  }

  Future editUser(UserModel userModel) async {
    try {
      updatingUser.value = true;
      var editedUser = await userRepo.editUser(userModel);
      _userModel.value = editedUser;
      await authRepo.saveUserLocal(editedUser);
      await Future.delayed(const Duration(microseconds: 300));
      DialogHelpers.showMessage('Update profile successfully.');
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> Update user error: $err');
      }
      DialogHelpers.showErrorMessage(err.toString());
    }
    updatingUser.value = false;
  }

  Future verifyPhone(
    String phone, {
    String? redirectRoute,
    bool resendCode = false,
  }) async {
    if (!_checkPhoneInput(phone)) {
      return;
    }
    verifyLoading.value = true;
    try {
      await authRepo.verifyPhoneNumber(
        FormatHelpers.phoneNumber(phone),
        (userCredential, err) {
          if (err != null) {
            verifyLoading.value = false;
            DialogHelpers.showMessage(err.toString(), error: true);
            return;
          }
          verifyLoading.value = false;
          if (resendCode) {
            DialogHelpers.showMessage('OTP code is resent.');
          } else {
            if (redirectRoute != null) {
              Get.toNamed(redirectRoute);
            }
          }
        },
        resendCode: resendCode,
      );
    } on FirebaseAuthException catch (authErr) {
      if (kDebugMode) {
        debugPrint('>>> Verify phone number: $authErr');
      }
      DialogHelpers.showErrorMessage(authErr.message.toString());
    } catch (err) {
      if (kDebugMode) {
        debugPrint('>>> verify phone number: $err');
      }
      DialogHelpers.showErrorMessage('Something went wrong.');
    }
  }

  Future verifyOtp(String code, String redirectRoute) async {
    try {
      verifyOtpLoading.value = true;
      UserCredential userCredential = await authRepo.verifyOTP(code);
      if (userCredential.user == null) {
        Get.back();
        DialogHelpers.showErrorMessage('Verify OTP error occurred.');
        verifyOtpLoading.value = false;
        return;
      }
      Get.toNamed(redirectRoute);
    } on FirebaseAuthException catch (authErr) {
      String errMsg = authErr.message.toString();
      if (authErr.code == 'invalid-verification-code') {
        errMsg = 'OTP code invalid';
      } else if (authErr.code == 'requires-recent-login') {
        errMsg = 'Require authenticate.';
      }
      debugPrint('>>> Error: verify otp: $authErr');
      DialogHelpers.showErrorMessage(errMsg);
    } catch (err) {
      debugPrint('>>> Error: verify otp: $err');
      DialogHelpers.showErrorMessage('Something went wrong');
    }
    verifyOtpLoading.value = false;
  }

  Future createNewPassword(String password, String rePassword) async {
    if (!_checkPasswordInput(password, rePassword)) {
      return;
    }
    try {
      verifyLoading.value = true;
      _userModel.value =
          await authRepo.updateNewPassword(_phoneNumber, password);
      await Future.delayed(const Duration(milliseconds: 500));
      DialogHelpers.showCustomDialog(Get.context!, 'Reset Password Successful!',
          description: 'You will be directed to the homepage.',
          imagePath: Images.resetPassword,
          bottomWidget: const Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingSizeDefault,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ));
      verifyLoading.value = false;
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      // Get user model and go home.
      await authRepo.saveUserLocal(_userModel.value!);
      Get.offAllNamed(AppRoutes.homeRoute);
    } catch (e) {
      debugPrint('>>> Creating new password: $e');
      DialogHelpers.showErrorMessage(e.toString());
      verifyLoading.value = false;
    }
  }

  Future changePassword(
      String currentPassword, String password, String rePassword) async {
    if (!_checkPasswordInput(currentPassword) ||
        !_checkPasswordInput(password, rePassword)) {
      return;
    }
    try {
      verifyLoading.value = true;
      String message = await authRepo.changePassword(
          _phoneNumber, currentPassword, password);
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();
      DialogHelpers.showMessage(message);
    } catch (e) {
      debugPrint('>>> Change password error: $e');
      DialogHelpers.showErrorMessage(e.toString());
    }
    verifyLoading.value = false;
  }

  Future signOut() async {
    _userModel.value = null;
    await authRepo.deleteUserLocal();
    await authRepo.signOut();
    Get.offAllNamed(AppRoutes.authRoute);
  }

  bool _checkPhoneInput(String phone) {
    if (phone.isEmpty) {
      DialogHelpers.showMessage('Your Phone number not empty.', error: true);
      return false;
    }
    if (!phone.isPhoneNumber) {
      DialogHelpers.showMessage('Your phone number invalid.', error: true);
      return false;
    }
    return true;
  }

  bool _checkPasswordInput(String password, [String? rePassword]) {
    if (password.isEmpty) {
      DialogHelpers.showMessage('Your Password not empty.', error: true);
      return false;
    }
    if (password.length < 8) {
      DialogHelpers.showMessage('Your password must be at least 8 characters.',
          error: true);
      return false;
    }
    if (rePassword != null && rePassword.compareTo(password) != 0) {
      DialogHelpers.showMessage('Your confirm password not match.',
          error: true);
      return false;
    }
    return true;
  }

  void _getRememberPhonePassword() {
    _phoneNumber = authRepo.getRememberPhone();
    _password = authRepo.getRememberPassword();
  }

  void _rememberMeKeyListener() {
    rememberMe.value = authRepo.getRememberMe();
    rememberMe.listen((isRememberMe) {
      authRepo.saveRememberMe(isRememberMe);
    });
  }

  bool _checkProfileData(SignUpModel signUpModel) {
    if (signUpModel.fullName.isEmpty) {
      DialogHelpers.showErrorMessage('Your full name not empty.');
      return false;
    } else if (signUpModel.email.isEmpty) {
      DialogHelpers.showErrorMessage('Your email not empty.');
      return false;
    } else if (!signUpModel.email.isEmail) {
      DialogHelpers.showErrorMessage('Your email format invalid.');
      return false;
    } else if (signUpModel.birthday == null) {
      DialogHelpers.showErrorMessage('Your date of birth not empty.');
      return false;
    } else if (signUpModel.gender.isEmpty) {
      DialogHelpers.showErrorMessage('Your gender not empty.');
      return false;
    } else if (signUpModel.address.isEmpty) {
      DialogHelpers.showErrorMessage('Your address not empty.');
      return false;
    }
    return true;
  }
}
