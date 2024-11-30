import 'package:agrolyn/api/article_service.dart';
import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/api/video_service.dart';
import 'package:agrolyn/api/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonHomeNotifier extends ChangeNotifier {
  final BuildContext context;

  CommonHomeNotifier({required this.context}) {
    fetchArticles();
    fetchVideo();
    fetchProduct();
    fetchWeather();
  }

  final ArticleService _articleService = ArticleService();
  List articles = [];
  var detailArticle;

  void fetchArticles() async {
    articles = await _articleService.getArticles();
    notifyListeners();
  }

  void fetchDetailArticles(int id) async {
    detailArticle = await _articleService.getDetailArticle(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('detailArticle', detailArticle.toString());
    notifyListeners();
  }

  final VideoService _videoService = VideoService();
  List videos = [];

  void fetchVideo() async {
    videos = await _videoService.getVideos();
    notifyListeners();
  }

  final StoreService _storeService = StoreService();
  List products = [];

  void fetchProduct() async {
    products = await _storeService.getProducts();
    notifyListeners();
  }

  final WeatherService _weatherService = WeatherService();
  List weathers = [];

  void fetchWeather() async {
    final weatherData = await _weatherService.getWeather();
    if (weatherData.isNotEmpty) {
      weathers = [weatherData]; // Masukkan ke daftar (list)
    } else {
      weathers = [];
    }
    notifyListeners();
  }
}
