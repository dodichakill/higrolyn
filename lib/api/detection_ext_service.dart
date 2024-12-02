import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/api/detection_service.dart';
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

class DetectionExtService {
  final Dio _dio = Dio();

  DetectionExtService() {
    _dio.options.baseUrl = "http://194.31.53.102:5035";
    _dio.options.headers = {
      'Accept': 'application/json',
    };
    _dio.options.contentType = Headers.formUrlEncodedContentType;
  }

  Future<bool> fetchPredictCornDisease(FormData formData) async {
    // final token = await AuthService().getToken();
    try {
      final response = await _dio.post("/corn-disease-predict", data: formData);

      // print(response);
      if (response.statusCode == 200) {
        print("Prediksi Berhasil");
        final disease = response.data['prediction'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('disease', disease);
        print('=====');
        print(formData.toString());
        print('=====');
        final res =
            DetectionService().fetchPredictCornDisease(disease, formData);
        print(response.data);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Error Fetch Predict : $e");
      return false;
    }
  }
}
