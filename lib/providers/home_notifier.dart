import 'package:agrolyn/api/article_service.dart';
import 'package:agrolyn/api/harvest_calculator_services.dart';
import 'package:agrolyn/api/video_service.dart';
import 'package:agrolyn/api/weather_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeNotifier extends ChangeNotifier {
  final BuildContext? context;
  Offset chatbotPosition = const Offset(8, 700);
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final TextEditingController hargaPerKgController = TextEditingController();
  final TextEditingController luasSawahController = TextEditingController();
  DateTime tanggalTanam = DateTime.now();
  String selectedPlant = 'rice';

  bool isError = false;
  List<Map<String, dynamic>> harvestData = [];

  double? hargaPerKg;
  double? luasSawah;

  HomeNotifier({required this.context}) {
    fetchArticles();
    fetchVideo();
    fetchWeather();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final ArticleService _articleService = ArticleService();
  List articles = [];

  void setArticles(List<dynamic> articles) {
    articles = articles;
    notifyListeners();
  }

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

  void setChangePlant(String newPlant) {
    selectedPlant = newPlant;
    notifyListeners();
  }

  void setUpdateTanggalTanam(DateTime newDate) {
    tanggalTanam = newDate;
    notifyListeners();
  }

  Future<void> submit() async {
    if (keyForm.currentState?.validate() ?? false) {
      // Ambil nilai dari TextEditingController
      hargaPerKg = double.tryParse(hargaPerKgController.text);
      luasSawah = double.tryParse(luasSawahController.text);

      // Debugging prints
      print('Harga Per Kg: $hargaPerKg');
      print('Luas Sawah: $luasSawah');
      print('Tanggal Tanam: ${DateFormat('yyyy-MM-dd').format(tanggalTanam)}');

      if (hargaPerKg == null || luasSawah == null) {
        isError = true;
        notifyListeners();
        return;
      }

      isError = false;
      notifyListeners();

      try {
        // Pengiriman data ke API menggunakan HarvestCalculatorService
        final service = HarvestCalculatorService();
        final response = await service.fetchNewHarvestCalculator(
          selectedPlant,
          {
            'harga_per_kg': hargaPerKg,
            'luas_sawah': luasSawah,
            'tanggal_tanam': DateFormat('yyyy-MM-dd').format(tanggalTanam),
            'jenis_tanaman': selectedPlant,
          },
        );

        if (response != null) {
          // Memperbarui harvestData dengan data dari API
          harvestData = [
            {
              'sisa_hari': response['sisa_hari'],
              'tanggal_panen': response['tanggal_panen'],
              'total_harga_rupiah': response['total_harga_rupiah'],
              'total_hasil_kilogram': response['total_hasil_kilogram'],
              'total_hasil_ton': response['total_hasil_ton'],
            },
          ];
        } else {
          isError = true;
        }

        notifyListeners();
      } catch (e) {
        if (e is DioException) {
          print('Dio Error: ${e.response?.data}');
          print('Dio Error Status Code: ${e.response?.statusCode}');
          print('Dio Error Headers: ${e.response?.headers}');
          print('Dio Error Request: ${e.requestOptions}');
        } else {
          print('Error: $e');
        }
        isError = true;
        notifyListeners();
      }
    }
  }
}
