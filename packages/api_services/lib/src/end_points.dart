class EndPoints {
  static String baseUrl = 'http://127.0.0.1:8000/api';

  // Authentication
  static String login() => '$baseUrl/auth/login';
  static String register() => '$baseUrl/auth/register';
  static String otpVerification() => '$baseUrl/auth/verify-phone';
  static String saveFCM() => '$baseUrl/auth/save_fcm';
}
