class EndPoints {
  static String baseUrl = 'https://fortpart.fannyjeddah.com/api';

  // Authentication
  static String login() => '$baseUrl/auth/login';
  static String register() => '$baseUrl/auth/register';
  static String otpVerification() => '$baseUrl/auth/verify-phone';
  static String saveFCM() => '$baseUrl/auth/save_fcm';
  static String updateProfile() => '$baseUrl/auth/update_profile';

  // Settings
  static String settings() => '$baseUrl/settings';
  static String categories() => '$baseUrl/categories';
  static String categoryProducts({required int categoryID}) => '$baseUrl/categories-product/$categoryID';

  // Cart
  static String addToCart() => '$baseUrl/auth/add-product-to-cart';
  static String myCart() => '$baseUrl/auth/my-cart';
  static String updateCart() => '$baseUrl/auth/update-cart';
  static String deleteItemFromCart() => '$baseUrl/auth/delete-item-cart';

  // Coupon
  static String fetchCoupons() => '$baseUrl/auth/coupons';
  static String activateCoupon() => '$baseUrl/auth/change-active-coupon';

  // Coupon
  static String address() => '$baseUrl/auth/address';
}
