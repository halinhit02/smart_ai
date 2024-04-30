import 'package:get/get.dart';
import 'package:smart_ai/ui/screen/auth/auth_screen.dart';
import 'package:smart_ai/ui/screen/chat/chat_screen.dart';
import 'package:smart_ai/ui/screen/forgot_password/forgot_password_screen.dart';
import 'package:smart_ai/ui/screen/history_search/history_search_screen.dart';
import 'package:smart_ai/ui/screen/home/home_screen.dart';
import 'package:smart_ai/ui/screen/create_chat/create_chat_screen.dart';
import 'package:smart_ai/ui/screen/create_assistant_chat/create_assistant_screen.dart';
import 'package:smart_ai/ui/screen/new_password/new_password_screen.dart';
import 'package:smart_ai/ui/screen/onboard/onboard_screen.dart';
import 'package:smart_ai/ui/screen/otp_verification/opt_verification_screen.dart';
import 'package:smart_ai/ui/screen/sign_in/sign_in_screen.dart';
import 'package:smart_ai/ui/screen/sign_up/sign_up_screen.dart';
import 'package:smart_ai/ui/screen/welcome/welcome_screen.dart';

class AppRoutes {
  // endpoints
  static const _onboard = '/onboard';
  static const _auth = '/auth';
  static const _signIn = '/sign-in';
  static const _signUp = '/sign-up';
  static const _forgotPassword = '/forgot_password';
  static const _otpVerification = '/otp_verification';
  static const _newPassword = '/new_password';
  static const _welcome = '/welcome';
  static const _home = '/home';
  static const _chat = '/chat';
  static const _createChat = '/create-chat';
  static const _createAssistantChat = '/create-assistant-chat';
  static const _historySearch = '/history-search';

  // route
  static String get welcomeRoute => _welcome;

  static String get authRoute => _auth;

  static String get signInRoute => _signIn;

  static String get signUpRoute => _signUp;

  static String get forgotPasswordRoute => _forgotPassword;

  static String get newPassword => _newPassword;

  static String get homeRoute => _home;

  static String get chatRoute => _chat;

  static String get createChatRoute => _createChat;

  static String get historySearchRoute => _historySearch;

  static String get onboardRoute => _onboard;

  static String get otpVerificationRoute => _otpVerification;

  static String createAssistantChat(
          String title, String description, String index) =>
      '$_createAssistantChat?index=$index&title=$title&description=$description';

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
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _chat,
      page: () => const ChatScreen(),
    ),
    GetPage(
      name: _createChat,
      page: () => const CreateChatScreen(),
    ),
    GetPage(
      name: _createAssistantChat,
      page: () => CreateAssistantScreen(
        title: Get.parameters['title'],
        description: Get.parameters['description'],
        index: Get.parameters['index'] ?? '0',
      ),
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
      page: () => const OTPVerificationScreen(),
    ),
    GetPage(
      name: _newPassword,
      page: () => const NewPasswordScreen(),
    ),
  ];
}
