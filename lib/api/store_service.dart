import 'package:agrolyn/api/auth_service.dart';
import 'package:dio/dio.dart';

class StoreService {
  final Dio _dio = Dio();

  Future<List> getProducts() async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.get('https://apiv1.agrolyn.online/ecommerce/products/',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));
      if (response.data['data'] != null) {
        return response.data['data']; // Mengembalikan semua produk
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
