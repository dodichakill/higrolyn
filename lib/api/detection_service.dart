import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/widgets/common_menu.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetectionService {
  final Dio _dio = Dio();

  DetectionService() {
    _dio.options.baseUrl = "https://apiv1.agrolyn.online";
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // Fungsi untuk login
  Future<bool> fetchPredictCornDisease(
      String disease, FormData formData) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post("/corn-disease-predict/$disease/",
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      // print(response);
      if (response.statusCode == 200) {
        print("Fetch disease Berhasil");
        print(response.data['prediction']);
        return true;
      } else {
        print("Fetch disease Gagal");
        return false;
      }
    } on DioException catch (e) {
      print("Feth disease error: $e");
      return false;
    }
  }

  Future<List> fetchGetHistory() async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get("/history/detection-history/",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      // print(response);
      if (response.statusCode == 200) {
        print(response.data['data']);
        print("Fetch History Berhasil");
        return response.data['data'];
      } else {
        print("Fetch History Gagal");
        return [];
      }
    } on DioException catch (e) {
      print("Feth History error: $e");
      return [];
    }
  }
}
