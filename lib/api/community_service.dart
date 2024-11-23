import 'package:agrolyn/api/auth_service.dart';
import 'package:dio/dio.dart';

class CommunityService {
  final Dio _dio = Dio();
  String baseUrl = "https://apiv1.agrolyn.online/community";

  Future<List> getQuestions() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get('$baseUrl/questions/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.data['data'] != null) {
        return response.data['data']; // Mengembalikan semua pertanyaan
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<String> fetchLikeQuestion(int questionId) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post('$baseUrl/questions/$questionId/like/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Like Berhasil");
        return "Like Berhasil";
      } else {
        print("Like Gagal");
        return "Like Gagal";
      }
    } catch (e) {
      print("Error: $e");
      return "Like Gagal";
    }
  }

  Future<String> fetchDislikeQuestion(int questionId) async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.post('$baseUrl/questions/$questionId/dislike/',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      print(response);
      if (response.statusCode == 200) {
        print("Dislike Berhasil");
        return "Dislike Berhasil";
      } else {
        print("Dislike Gagal");
        return "Dislike Gagal";
      }
    } catch (e) {
      print("Error: $e");
      return "Dislike Gagal";
    }
  }
}
