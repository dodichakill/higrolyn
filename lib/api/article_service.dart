import 'package:agrolyn/api/auth_service.dart';
import 'package:dio/dio.dart';

class ArticleService {
  final Dio _dio = Dio();

  Future<List> getArticles() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get('https://apiv1.agrolyn.my.id/articles/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
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

  Future<Map<String, dynamic>> getDetailArticle(int articleId) async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.get('https://apiv1.agrolyn.my.id/articles/$articleId/',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      if (response.data['data'] != null) {
        return response.data['data'];
      } else {
        throw Exception('No data found for the article.');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      }
      throw Exception('Error fetching article details: $e');
    }
  }
}
