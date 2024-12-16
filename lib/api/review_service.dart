import 'package:dio/dio.dart';
import 'package:agrolyn/api/auth_service.dart';
import 'package:flutter/material.dart';

class ReviewService {
  final Dio _dio = Dio();

  Future<String?> fetchNewReview(Map<String, dynamic> data) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post(
        'https://apiv1.agrolyn.online/app/review/', // Ensure this URL is correct
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return "Ulasan berhasil ditambahkan";
      } else {
        return "Ulasan gagal ditambahkan: ${response.data['message']}";
      }
    } catch (e) {
      if (e is DioException) {
        print("DioException: ${e.response?.data}");
        return "Ulasan gagal ditambahkan: ${e.response?.data['message']}";
      } else {
        print("Error: $e");
        return "Ulasan gagal ditambahkan: $e";
      }
    }
  }
}
