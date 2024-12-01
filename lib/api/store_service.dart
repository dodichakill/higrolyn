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

  Future<bool> createProduct(
      context,
      String product_name,
      String desc_product,
      int price,
      int stock,
      String product_categories_id,
      String? img_product) async {
    final token = await AuthService().getToken();
    try {
      // Jika img_product bukan null, lakukan upload file
      FormData formData = FormData.fromMap({
        "product_name": product_name,
        "desc_product": desc_product,
        "price": price,
        "stock": stock,
        "product_categories_id": product_categories_id,
        if (img_product != null)
          "img_product": await MultipartFile.fromFile(img_product),
      });

      final response = await _dio.post(
          "https://apiv1.agrolyn.online/ecommerce/products/new-product/",
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        // Handle successful creation of product
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('product_name', response.data['product_name']);
        await prefs.setString('desc_product', response.data['desc_product']);
        await prefs.setInt('price', response.data['price']);
        await prefs.setInt('stock', response.data['stock']);
        await prefs.setString(
            'product_categories_id', response.data['product_categories_id']);
        await prefs.setString('img_product', response.data['img_product']);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = "Terjadi kesalahan";
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      showCustomSnackbar(
          context, "Tambah Produk Gagal", errorMessage, ContentType.failure);
      print("Tambah Produk error: $e");
      return false;
    }
  }
}
