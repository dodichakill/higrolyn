import 'dart:io';

import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
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

  Future<String?> fetchNewProduct(FormData formData) async {
    final token = await AuthService().getToken();
    try {
      print("FormData: ${formData.fields}");
      final response = await _dio.post(
        'https://apiv1.agrolyn.online/ecommerce/products/new-product/',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print("Response Status: ${response.statusCode}");
      print("Response Data: ${response.data}");
      if (response.statusCode == 201) {
        return "Produk berhasil ditambahkan";
      } else {
        return "Produk gagal ditambahkan: ${response.data['message']}";
      }
    } catch (e) {
      if (e is DioException) {
        print("DioException: ${e.response?.data}");
        return "Produk gagal ditambahkan: ${e.response?.data['message']}";
      } else {
        print("Error: $e");
        return "Produk gagal ditambahkan: $e";
      }
    }
  }

  Future<void> deleteProduct(int id) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.delete(
          'https://apiv1.agrolyn.online/ecommerce/products/delete-product/$id/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        print("Produk berhasil dihapus");
      } else {
        throw Exception("Produk gagal dihapus");
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.data}");
      throw Exception("Produk gagal dihapus: ${e.response?.data['message']}");
    } catch (e) {
      print("Error: $e");
      throw Exception("Produk gagal dihapus: $e");
    }
  }

  Future<bool> updateProduct(
    BuildContext context,
    int id,
    String name,
    String desc,
    int price,
    int stock,
    String category,
    File image, // Image passed to function
  ) async {
    final token = await AuthService().getToken();

    // Log data that will be sent to the server
    print("Token: $token");
    print("ID: $id");
    print("Name: $name");
    print("Description: $desc");
    print("Price: $price");
    print("Stock: $stock");
    print("Category: $category");
    print("Image Path: ${image.path}");

    try {
      // Prepare form data with image (send the new image if provided)
      String uniqueFileName =
          "product_${DateTime.now().millisecondsSinceEpoch}.jpg";

      FormData formData = FormData.fromMap({
        'product_name':
            name, // Adjusted field names based on the response from API
        'desc_product': desc,
        'price': price,
        'stock': stock,
        'category': category,
        'image': image.existsSync()
            ? await MultipartFile.fromFile(image.path, filename: uniqueFileName)
            : null, // If no image selected, send null or default image if needed
      });

      final response = await _dio.put(
        'https://apiv1.agrolyn.online/ecommerce/products/update-product/$id/',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      // Log response status and data
      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        String? updatedImage = response.data['updated_product']['img_product'];
        if (updatedImage != null) {
          showCustomSnackbar(context, "Produk Tersimpan",
              "Produk Berhasil diubah", ContentType.success);
          Future.delayed(const Duration(seconds: 2), () {
            pushWithNavBar(
                context,
                MaterialPageRoute(
                    builder: (context) => Menu(
                          page: PersistentTabController(initialIndex: 1),
                        )));
          });
          return true;
        } else {
          showCustomSnackbar(
              context,
              "Gagal Menyimpan Gambar",
              "Gambar gagal diperbarui, silahkan coba lagi",
              ContentType.failure);
          return false;
        }
      } else {
        print("Produk gagal diupdate: ${response.data['message']}");
        showCustomSnackbar(context, "Gagal Menyimpan Data",
            "Produk gagal diubah, silahkan dicoba lagi", ContentType.failure);
        return false;
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.data}");
      showCustomSnackbar(context, "Gagal Menyimpan Data",
          "Produk gagal diubah, silahkan dicoba lagi", ContentType.failure);
      return false;
    } catch (e) {
      print("Error: $e");
      showCustomSnackbar(context, "Error tidak diketahui",
          "Terjadi kesalahan, silahkan coba lagi", ContentType.failure);
      return false;
    }
  }

  Future<List> fetchSearchProduct(String keyword) async {
    final token = await AuthService().getToken();
    try {
      final response = await _dio.get(
          'https://apiv1.agrolyn.online/ecommerce/products/search/?query=$keyword/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        return response.data['data']; // Mengembalikan semua produk
      } else {
        print("Produk tidak ditemukan");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
