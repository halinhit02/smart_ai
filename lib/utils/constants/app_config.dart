class AppConfig {
  static const genderName = ['Male', 'Female', 'Other'];
  static const genders = ['male', 'female', 'other'];

  // APIs
  static const baseUrl = 'http://localhost:3000/v1';

  // Endpoints
  static const authEndpoint = '/auth';
  static const userEndpoint = '/user';
  static const chatEndpoint = '/chat';
  static const messageEndpoint = '/message';
  static const imageEndpoint = '/image';
  static const assistantEndpoint = '/assistant';

  static const signInEndpoint = '$authEndpoint/sign-in';
  static const signUpEndpoint = '$authEndpoint/sign-up';
  static const forgotPasswordEndpoint = '$authEndpoint/forgot-password';
  static const checkPhoneEndpoint = '$authEndpoint/check-phone';
  static const changePasswordEndpoint = '$authEndpoint/change-password';


  // Remote config

  static const chatModelNameKey = 'chatModelName';
  static const chatModelsKey = 'chatModels';
  static const privacyLinkKey = 'privacy_link';

  static Map<String, dynamic> defaultParameters = {
    chatModelNameKey: 'gpt-4; gpt-3.5; gemini-pro',
    chatModelsKey: 'gpt-4-turbo; gpt-3.5-turbo; gemini-pro',
    privacyLinkKey: 'https://google.com',
  };
}
