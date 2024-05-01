import 'package:get/get.dart';
import 'package:smart_ai/binding/home_binding.dart';
import 'package:smart_ai/binding/message_binding.dart';
import 'package:smart_ai/middleware/auth_middleware.dart';
import 'package:smart_ai/ui/screen/auth/auth_screen.dart';
import 'package:smart_ai/ui/screen/change_password/change_password_screen.dart';
import 'package:smart_ai/ui/screen/chat/chat_screen.dart';
import 'package:smart_ai/ui/screen/complete_profile/complete_profile_screen.dart';
import 'package:smart_ai/ui/screen/forgot_password/forgot_password_screen.dart';
import 'package:smart_ai/ui/screen/history_search/history_search_screen.dart';
import 'package:smart_ai/ui/screen/home/home_screen.dart';
import 'package:smart_ai/ui/screen/create_chat/create_chat_screen.dart';
import 'package:smart_ai/ui/screen/create_assistant_chat/create_assistant_screen.dart';
import 'package:smart_ai/ui/screen/image_history/image_history_screen.dart';
import 'package:smart_ai/ui/screen/new_password/new_password_screen.dart';
import 'package:smart_ai/ui/screen/onboard/onboard_screen.dart';
import 'package:smart_ai/ui/screen/otp_verification/opt_verification_screen.dart';
import 'package:smart_ai/ui/screen/result_image/result_image_screen.dart';
import 'package:smart_ai/ui/screen/sign_in/sign_in_screen.dart';
import 'package:smart_ai/ui/screen/sign_up/sign_up_screen.dart';
import 'package:smart_ai/ui/screen/welcome/welcome_screen.dart';

import '../../ui/screen/change_profile/change_profile_screen.dart';

class AppRoutes {
  // endpoints
  static const _onboard = '/onboard';
  static const _auth = '/auth';
  static const _signIn = '/sign-in';
  static const _signUp = '/sign-up';
  static const _forgotPassword = '/forgot-password';
  static const _otpVerification = '/otp-verification';
  static const _completeProfile = '/complete-profile';
  static const _newPassword = '/new-password';
  static const _welcome = '/welcome';
  static const _home = '/home';
  static const _chat = '/chat';
  static const _createChat = '/create-chat';
  static const _createAssistantChat = '/create-assistant-chat';
  static const _historySearch = '/history-search';
  static const _resultImage = '/result-image';
  static const _imageHistory = '/image-history';
  static const _changeProfile = '/change-profile';
  static const _changePassword = '/change-password';

  // route
  static String get welcomeRoute => _welcome;

  static String get authRoute => _auth;

  static String get signInRoute => _signIn;

  static String get signUpRoute => _signUp;

  static String get forgotPasswordRoute => _forgotPassword;

  static String get newPasswordRoute => _newPassword;

  static String get completeProfile => _completeProfile;

  static String get homeRoute => _home;

  static String get createChatRoute => _createChat;

  static String get historySearchRoute => _historySearch;

  static String get onboardRoute => _onboard;

  static String get historyImageRoute => _imageHistory;

  static String get changeProfileRoute => _changeProfile;

  static String get changePasswordRoute => _changePassword;

  static String otpVerificationRoute([String? redirectRoute]) =>
      redirectRoute != null
          ? '$_otpVerification?redirect-route=$redirectRoute'
          : _otpVerification;

  static String createAssistantChat(String title, int assistantId) =>
      '$_createAssistantChat?assistant-id=$assistantId&title=$title';

  static String chatRoute(
          {String? id,
          String? message,
          String? modelId,
          bool fromCreate = true,
          int? assistantId}) =>
      '$_chat?id=$id&title=$message&model-id=$modelId&from-create=$fromCreate&assistant-id=$assistantId';

  static String resultImageRoute({int? imageId}) =>
      '$_resultImage?image-id=$imageId';

  static List<GetPage> pages = [
    GetPage(
      name: _onboard,
      page: () => const OnboardScreen(),
    ),
    GetPage(
      name: _auth,
      page: () => const AuthScreen(),
    ),
    GetPage(
      name: _welcome,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: _home,
      binding: HomeBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _chat,
      binding: MessageBinding(),
      page: () => ChatScreen(
        id: Get.parameters['id'],
        modelId: Get.parameters['model-id'] ?? '',
        title: Get.parameters['title'] ?? '',
        fromCreate: bool.tryParse(Get.parameters['from-create'] ?? 'true')!,
        assistantId: Get.parameters['assistant-id'],
      ),
    ),
    GetPage(
      name: _createChat,
      page: () => const CreateChatScreen(),
    ),
    GetPage(
      name: _createAssistantChat,
      page: () => CreateAssistantScreen(
          title: Get.parameters['title'] ?? 'Unknown',
          assistantId: Get.parameters['assistant-id'] ?? '-1'),
    ),
    GetPage(
      name: _historySearch,
      page: () => const HistorySearchScreen(),
    ),
    GetPage(
      name: _signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: _signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: _forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: _otpVerification,
      page: () => OTPVerificationScreen(
        redirectRoute: Get.parameters['redirect-route'] ?? homeRoute,
      ),
    ),
    GetPage(
      name: _newPassword,
      page: () => const NewPasswordScreen(),
    ),
    GetPage(
      name: _completeProfile,
      page: () => const CompleteProfileScreen(),
    ),
    GetPage(
      name: _resultImage,
      page: () => ResultImageScreen(
        imageId: Get.parameters['image-id'],
      ),
    ),
    GetPage(
      name: _imageHistory,
      page: () => const ImageHistoryScreen(),
    ),
    GetPage(
      name: _changeProfile,
      page: () => const ChangeProfileScreen(),
    ),
    GetPage(
      name: _changePassword,
      page: () => const ChangePasswordScreen(),
    ),
  ];
}
