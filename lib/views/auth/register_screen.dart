import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/providers/register_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterNotifier(context: context),
      child: Consumer<RegisterNotifier>(
        builder: (context, value, child) => Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  child: Image.asset(ImageAssets.bgSore,
                      fit: BoxFit.cover, height: double.infinity),
                ),
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 80,
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.2), // Semi-transparent color
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color:
                                  Colors.white.withOpacity(0.4), // Border color
                              width: 1.5,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        Image.asset(
                                          ImageAssets.logo,
                                          height: 192,
                                          width: 192,
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Daftar Akun',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Daftar Akun Untuk Mengakses Aplikasi',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 32),

                                  // Section: Name Field
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        key: const Key('Nama'),
                                        controller: value.nameController,
                                        decoration: InputDecoration(
                                          labelText: 'Nama',
                                          labelStyle: const TextStyle(
                                              color: Colors
                                                  .white), // Warna teks label
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat tidak fokus
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat fokus
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Nama Tidak boleh kosong";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Section: Email Field
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        key: const Key('Email'),
                                        controller: value.emailController,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: const TextStyle(
                                              color: Colors
                                                  .white), // Warna teks label
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat tidak fokus
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat fokus
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Email Tidak boleh kosong";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),
                                  // Section: Phone Number Field
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        key: const Key('Nomor Hp'),
                                        controller: value.phoneController,
                                        decoration: InputDecoration(
                                          labelText: 'Nomor Hp',
                                          prefix: const Text(
                                            '+62 ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Colors
                                                  .white), // Warna teks label
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat tidak fokus
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat fokus
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Nomor HP Tidak boleh kosong";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  // Section: Address Field
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        key: const Key('Alamat'),
                                        controller: value.addressController,
                                        decoration: InputDecoration(
                                          labelText: 'Alamat',
                                          labelStyle: const TextStyle(
                                              color: Colors
                                                  .white), // Warna teks label
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat tidak fokus
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat fokus
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Alamat Tidak boleh kosong";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        key: const Key('Kata Sandi'),
                                        controller: value.passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Kata Sandi',
                                          labelStyle: const TextStyle(
                                              color: Colors
                                                  .white), // Warna teks label
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat tidak fokus
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors
                                                    .white), // Border saat fokus
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors
                                                .white), // Warna teks input
                                        validator: (e) {
                                          if (e!.isEmpty) {
                                            return "Kata Sandi Tidak boleh kosong";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  // Section: Sign Up Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      key: const Key('registerButton'),
                                      onPressed: () async {
                                        value.setLoading(true);
                                        //kalo testpake ini
                                        // SharedPreferences prefs =
                                        //     await SharedPreferences
                                        //         .getInstance();
                                        // String? id = prefs
                                        //         .getString('role_choice') ??
                                        //     '2'; // Menyediakan nilai default '2'
                                        // print(
                                        //     "${int.parse(id)} ${value.nameController.text} ${value.emailController.text} ${value.phoneController.text} ${value.addressController.text} ${value.passwordController.text}");

                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        String? id =
                                            prefs.getString('role_choice');
                                        print(
                                            "${int.parse(id ?? '0')} ${value.nameController.text} ${value.emailController.text} ${value.phoneController.text} ${value.addressController.text} ${value.passwordController.text}");
                                        // if (value.keyfrom.currentState!
                                        //     .validate()) {
                                        AuthService()
                                            .register(
                                                context,
                                                int.parse(id!),
                                                value.nameController.text,
                                                value.emailController.text,
                                                value.phoneController.text,
                                                value.addressController.text,
                                                value.passwordController.text)
                                            .whenComplete(
                                                () => value.setLoading(false));
                                        // }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: value.isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text(
                                              'Daftar',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Section: Register Option
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Sudah Punya Akun ?',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()),
                                            );
                                          },
                                          child: const Text(
                                            'Masuk',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
