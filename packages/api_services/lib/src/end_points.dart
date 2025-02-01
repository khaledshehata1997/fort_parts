class EndPoints {
  static String baseUrl = 'https://fortpart.fannyjeddah.com/api';

  // Authentication
  static String login() => '$baseUrl/auth/login';
  static String register() => '$baseUrl/auth/register';
  static String otpVerification() => '$baseUrl/auth/verify-phone';
  static String saveFCM() => '$baseUrl/auth/save_fcm';

  // Settings
  static String settings() => '$baseUrl/settings';
  static String categories() => '$baseUrl/categories';
  static String categoryProducts({required int categoryID}) =>
      '$baseUrl/categories-product/$categoryID';
}
