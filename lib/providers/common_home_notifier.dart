import 'package:agrolyn/api/article_service.dart';
import 'package:agrolyn/api/video_service.dart';
import 'package:flutter/material.dart';

class CommonHomeNotifier extends ChangeNotifier {
  final BuildContext context;

  CommonHomeNotifier({required this.context}) {
    fetchArticles();
    fetchVideo();
  }
  final ArticleService _articleService = ArticleService();
  List articles = [];

  void fetchArticles() async {
    articles = await _articleService.getArticles();
    notifyListeners();
  }

  final VideoService _videoService = VideoService();
  List videos = [];

  void fetchVideo() async {
    videos = await _videoService.getVideo();
    notifyListeners();
  }
}
