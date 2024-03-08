class ApiEndPoints {
  static String baseUrl = 'http://10.0.2.2:5000';
  static String userProfile = '/me';
  static String userSignUp = '/signup';
  static String userSignIn = '/login';
  static String userVerifyOtp = "/signup-send-otp";
  static String forgetSendOtp = "/forget-send-otp";
  static String resetPassword = "/forget-password";

  static String allPosts = "/posts";
  static String addComment = "/post/comment/add";
  static String deleteComment = "/post/comment/delete";
}
