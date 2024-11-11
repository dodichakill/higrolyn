import 'package:agrolyn/api/article_service.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  final BuildContext context;
  Offset chatbotPosition = Offset(8, 775);

  HomeNotifier({required this.context}) {
    fetchArticles();
  }

  final ArticleService _articleService = ArticleService();
  List articles = [];

  void fetchArticles() async {
    articles = await _articleService.getArticles();
    notifyListeners();
  }

  void updateChatbotPosition(Offset newPosition) {
    chatbotPosition = newPosition;
    notifyListeners(); // Trigger UI update with the new position
  }
}
