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
      // print(response);
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

  Future<Map<String, dynamic>> getDetailQuestion(int questionId) async {
    final token = await AuthService().getToken();
    try {
      // print('Fetching detail for question ID: $questionId');
      final response = await _dio.get('$baseUrl/questions/$questionId/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      // print('Response: ${response.data}');
      if (response.data['data'] != null) {
        return response.data['data'];
      } else {
        throw Exception('No data found for the question.');
      }
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      }
      throw Exception('Error fetching question details: $e');
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

  Future<String?> fetchNewAnswer(
      {required int questionId,
      required String answer,
      required int type}) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post('$baseUrl/answer/new/$questionId/',
          data: {
            "answer": answer,
            "plant_types_id": type,
          },
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        print("Jawaban Gagal dibuat");
        return response.data['message'];
      }
    } catch (e) {
      print("Error: $e");
      return "Jawaban Gagal dibuat";
    }
  }

  Future<String> fetchDeleteAnwser(int answerId) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.delete('$baseUrl/answer/delete/$answerId/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        print("Jawaban Berhasil dihapus");
        return "Jawaban Berhasil dihapus";
      } else {
        print("Jawaban Gagal dihapus");
        return "Jawaban Gagal dihapus";
      }
    } catch (e) {
      print("Error: $e");
      return "Jawaban Gagal dihapus";
    }
  }
}
