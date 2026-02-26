class ApiUrls {
  //static const String baseUrl = "http://217.15.170.117";
  static const String baseUrl = "https://mihad3000.merinasib.shop/api/v1";


  //static const String imageBaseUrl = "http://217.15.170.117/";
  static const String imageBaseUrl = "https://mihad3000.merinasib.shop/";


  //static const String socketUrl = "http://217.15.170.117";
  static const String socketUrl = "https://mihad3000.merinasib.shop";

  static const String userData = '/users/me';
  static const String register = '$baseUrl/auth/create';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String login = '$baseUrl/auth/login';
  static const String forgetPassword = '/auth/forget-password';
  static  String  resendOtp(String email) => '$baseUrl/auth/resend-otp?$email';
  static  const String  resetPassword = '/auth/reset-password';
  static   String  resendVerifyOtp(String userEmail) => 'auth/resend-otp/$userEmail';

  static  const String  terms = '/rules/terms';
  static  const String  about = '/rules/aboutus';
  static  const String  privacy = '/rules/privacy';

  static  const String  changePassword = '/auth/reset-password';
  static  const String  updateProfile = '/users/update-profile';
  static  const String  parentCreate = '/parents/parent';
  static  const String  siteUrl = '$baseUrl/site/';
  static  const String  assignedSiteUrl = '$baseUrl/office-admin/assigned-sites';
  static  String  sendMessage(String conversationID) => '/messages/$conversationID/send-message';

}
