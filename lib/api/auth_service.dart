import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  AuthService() {
    _dio.options.baseUrl =
        "https://apiv1.agrolyn.online"; // Sesuaikan URL API Anda
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // Fungsi untuk login
  Future<bool> login(context, String email, String password) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {
          "email": email.toString(),
          "password": password.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Simpan token di SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('refresh_token', response.data['refresh_token']);
        await prefs.setString('access_token', response.data['access_token']);
        await prefs.setString('name', response.data['name']);
        await prefs.setString('address', response.data['address']);
        await prefs.setString('phone_number', response.data['phone_number']);
        await prefs.setString('email', response.data['email']);
        await prefs.setString('id', response.data['id'].toString());
        await prefs.setString('img_profile', response.data['img_profile']);
        await prefs.setString('roles_id', response.data['roles_id'].toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Menu()),
        );

        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Login error: ${e.response?.data}");
      showCustomSnackbar(context, "Login Gagal",
          "Periksa email dan kata sandi anda", ContentType.failure);
      return false;
    }
  }

  // Fungsi untuk login
  Future<bool> register(context, int id, String name, String email,
      String phoneNumber, String address, String password) async {
    try {
      final response = await _dio.post(
        "/register",
        data: {
          "roles_id": id,
          "name": name.toString(),
          "email": email.toString(),
          "phone_number": phoneNumber.toString(),
          "address": address.toString(),
          "password": password.toString(),
        },
      );

      if (response.statusCode == 201) {
        // print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: MyColors.primaryColorDark,
              content: Text(
                "Pendaftaran Berhasil, silahkan cek email anda untuk verifikasi akun",
                style: TextStyle(color: Colors.white),
              )),
        );
        showCustomSnackbar(
            context,
            "Pendaftaran Berhasil",
            "silahkan cek email anda untuk verifikasi akun",
            ContentType.success);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Register error: ${e.response?.data['message']}");
      showCustomSnackbar(context, "Gagal Daftar",
          "Pendaftaran akun gagal, silahkan dicoba lagi", ContentType.failure);

      return false;
    }
  }

  // edit profile
  Future<bool> editProfile(
      context, String name, String phoneNumber, String address) async {
    try {
      final token = await getToken();
      final response = await _dio.put(
        "/edit-profile",
        data: {
          "name": name.toString(),
          "phone_number": phoneNumber.toString(),
          "address": address.toString(),
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print(response);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', name);
        await prefs.setString('address', address);
        await prefs.setString('phone_number', phoneNumber);
        PersistentTabController profile =
            PersistentTabController(initialIndex: 4);

        showCustomSnackbar(context, "Data Tersimpan",
            "Berhasil Menyimpan perubahan data", ContentType.success);
        Future.delayed(const Duration(seconds: 3), () {
          pushWithNavBar(
              context,
              MaterialPageRoute(
                  builder: (context) => Menu(
                        page: profile,
                      )));
        });
        print(response.data);
        return true;
      }
      return false;
    } on DioException catch (e) {
      print("Update Profile error: ${e.response?.data['message']}");
      showCustomSnackbar(
          context,
          "Gagal Menyimpan Data",
          "Gagal Menyimpan perubahan data, silahkan coba lagi",
          ContentType.failure);

      return false;
    }
  }

  // Fungsi untuk mengambil token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Fungsi untuk logout
  Future<void> logout(context) async {
    // buatkan code untuk logout dengan endpoint /logout dan menambahkan token bernama 'access_token' di header
    final token = await getToken();
    print("Token: $token");
    if (token != null) {
      try {
        final res = await _dio.post(
          "/logout",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
        );

        if (res.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('access_token');
          pushReplacementWithoutNavBar(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      } on DioException catch (e) {
        print("Register error: ${e.response?.data['message']}");
        showCustomSnackbar(context, "Gagal Logout",
            "Logout gagal, silahkan dicoba lagi", ContentType.failure);
      }
    }
  }
}
