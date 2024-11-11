import 'package:dio/dio.dart';

class ArticleService {
  final Dio _dio = Dio();

  Future<List> getArticles() async {
    try {
      final response = await _dio.get('https://apiv1.agrolyn.online/articles/');
      if (response.data['data'] != null) {
        return response.data['data']; // Mengembalikan semua artikel
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
