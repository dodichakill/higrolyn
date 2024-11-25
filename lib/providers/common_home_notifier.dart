import 'package:agrolyn/api/article_service.dart';
import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/api/video_service.dart';
import 'package:flutter/material.dart';

class CommonHomeNotifier extends ChangeNotifier {
  final BuildContext context;

  CommonHomeNotifier({required this.context}) {
    fetchArticles();
    fetchVideo();
    fetchProduct();
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

  final StoreService _storeService = StoreService();
  List products = [];

  void fetchProduct() async {
    products = await _storeService.getProducts();
    notifyListeners();
  }
}
