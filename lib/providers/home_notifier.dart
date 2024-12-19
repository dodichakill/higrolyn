import 'package:agrolyn/api/article_service.dart';
import 'package:agrolyn/api/video_service.dart';
import 'package:agrolyn/api/weather_service.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  final BuildContext? context;
  Offset chatbotPosition = const Offset(8, 700);

  HomeNotifier({required this.context}) {
    fetchArticles();
    fetchVideo();
    fetchWeather();
  }

  final ArticleService _articleService = ArticleService();
  List articles = [];

  void fetchArticles() async {
    articles = await _articleService.getArticles();
    notifyListeners();
  }

  void updateChatbotPosition(Offset newPosition) {
    chatbotPosition = newPosition;
    notifyListeners();
  }

  final VideoService _videoService = VideoService();
  List videos = [];

  void fetchVideo() async {
    videos = await _videoService.getVideos();
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
