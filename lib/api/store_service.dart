import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List> getProductsMe() async {
    final token = await AuthService().getToken();
    try {
      final response =
          await _dio.get('https://apiv1.agrolyn.online/ecommerce/products/me/',
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

  Future<String?> fetchNewProduct({
    required String product_name,
    required String desc_product,
    required int price,
    required int stock,
    required String product_categories_id, // kategori harus berupa string
    required String?
        img_product, // gambar juga berupa string (misalnya path atau URL gambar)
  }) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.post(
        'https://apiv1.agrolyn.online/ecommerce/products/new-product/',
        data: {
          'product_name': product_name,
          'desc_product': desc_product,
          'price': price,
          'stock': stock,
          'product_categories_id': product_categories_id,
          'img_product': img_product,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print("Response Status: ${response.statusCode}");
      print("Response Data: ${response.data}");
    } catch (e) {
      if (e is DioException) {
        print("Error Status: ${e.response?.statusCode}");
        print("Error Message: ${e.response?.statusMessage}");
        print("Error Body: ${e.response?.data}");
        if (e.response?.data != null) {
          // Mencetak response body lebih lanjut
          print("Error Body (Full): ${e.response?.data}");
        }
      } else {
        print("Unexpected Error: $e");
      }
    }
  }
}
