import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  int? resendToken;
  String verificationId = '';

  bool get authenticated => _auth.currentUser != null;

  String get userUid => _auth.currentUser?.uid ?? '';

  Future verifyPhoneNumber(
    String phoneNumber,
    Function(UserCredential?, String?) onVerificationCompleted, {
    bool resendCode = false,
  }) {
    return _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      forceResendingToken: resendCode ? resendToken : null,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
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

  Future<UserCredential> verifyOTP(String otp) {
    if (verificationId.isEmpty) {
      return Future.error('something_wrong'.tr);
    }
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    return _auth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithAccount(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// Sign in with google account.
  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return _auth.signInWithCredential(credential);
  }

  /// Generates a cryptographically secure random nonce
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  ///Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ], nonce: nonce);
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    return _auth.signInWithCredential(oauthCredential);
  }

  Future updateNewPassword(String newPassword) {
    if (_auth.currentUser == null) {
      return Future.error('something_wrong'.tr);
    }
    return _auth.currentUser!.updatePassword(newPassword);
  }

  Future signOut() async {
    verificationId = '';
    resendToken = null;
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}
