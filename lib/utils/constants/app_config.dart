class AppConfig {
  static const genderName = ['Male', 'Female', 'Other'];
  static const genders = ['male', 'female', 'other'];

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
  static const chatModelNameKey = 'chat_model_name';
  static const chatModelsKey = 'chat_models';
  static const privacyLinkKey = 'privacy_link';
  static const openAIKey = 'open_ai_key';
  static const geminiKey = 'gemini_key';
  static const allowImageGenerationKey = 'allow_image_generation';
  static const allowSignIn = 'allow_sign_in';
  static const baseUrlKey = 'base_url';

  static Map<String, dynamic> defaultParameters = {
    chatModelNameKey: 'GPT-4; GPT-3.5; Gemini-Pro',
    chatModelsKey: 'gpt-4-turbo; gpt-3.5-turbo; gemini-pro',
    privacyLinkKey: 'https://google.com',
    openAIKey: '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',
    geminiKey: 'AIzaSyCAC-yAcj8qGc4CxEkg7aF_svabt5gZWJg',
    baseUrlKey: 'https://smartai.halinhit.com/v1',
    allowImageGenerationKey: true,
    allowSignIn: true,
  };
}
