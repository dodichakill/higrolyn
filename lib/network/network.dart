class AuthUrl {
  static String register() {
    return "https://apiv1.agrolyn.online/register";
  }
}

class ArticleUrl {
  static String baseUrl = "https://apiv1.agrolyn.online/articles";

  static String article() {
    return "$baseUrl/";
  }
}
