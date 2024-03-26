class ApiEndPoints {
  static String baseUrl = 'http://10.0.2.2:5000';
  static String profile = '/me';
  static String editUserProfile = '/profile/edit';
  static String userSignUp = '/signup';
  static String userSignIn = '/login';
  static String userVerifyOtp = "/signup-send-otp";
  static String forgetSendOtp = "/forget-send-otp";
  static String resetPassword = "/forget-password";

  static String allPosts = "/posts";
  static String createPost = "/createpost";
  static String editPost = "/post/";
  static String removePost = "/post/";

  static String addComment = "/post/comment/add";
  static String deleteComment = "/post/comment/delete";

  static String likePost = "/post/like/";
  static String unlikePost = "/post/unlike/";

  static String savePost = "/save-post/";
  static String unsavePost = "/unsave-post/";
  static String allSavedPosts = "/saved-post";

  static String allStories = "/stories";
  static String addStory = "/story/add";

  static String allUsers = '/users';
  static String user = '/user/';

  static String followUser = "/follow/";
  static String unfollowUser = "/unfollow/";

  static String userSearch = "/search";
}
