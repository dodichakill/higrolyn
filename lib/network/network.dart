class AuthUrl {
  static String register() {
    return "https://apiv1.agrolyn.my.id/register";
  }
}

class ArticleUrl {
  static String baseUrl = "https://apiv1.agrolyn.my.id/articles";

  static String article() {
    return "$baseUrl/";
  }
}
