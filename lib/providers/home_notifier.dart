import 'package:agrolyn/api/article_service.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  final BuildContext context;

  HomeNotifier({required this.context}) {
    fetchArticles();
  }

  final ArticleService _articleService = ArticleService();
  List articles = [];

  void fetchArticles() async {
    articles = await _articleService.getArticles();
    notifyListeners(); // Memperbarui tampilan setelah data diterima
  }
}
