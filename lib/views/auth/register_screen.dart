import 'package:agrolyn/providers/register_notifier.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterNotifier(context: context),
      child: Consumer<RegisterNotifier>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Form(
              key: value.keyfrom,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Image.asset(
                                ImageAssets.logo,
                                height: 192,
                                width: 192,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'Daftar Akun',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Daftar Akun Untuk Mengakses Aplikasi',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Section: Name Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nama',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return "Nama Tidak boleh kosong";
                                }
                                return null; // Mengembalikan null jika valid
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Section: Email Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return "Email Tidak boleh kosong";
                                }
                                return null; // Mengembalikan null jika valid
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Section: Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            TextFormField(
                              obscureText:
                                  true, // Menyembunyikan input password
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return "Password Tidak boleh kosong";
                                }
                                return null; // Mengembalikan null jika valid
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Section: Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            TextFormField(
                              obscureText:
                                  true, // Menyembunyikan input password
                              decoration: InputDecoration(
                                labelText: 'Konfirmasi Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (e) {
                                if (e!.isEmpty) {
                                  return "Konfirmasi Password Tidak boleh kosong";
                                }
                                return null; // Mengembalikan null jika valid
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Section: Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Lupa Password',
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Section: Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (value.keyfrom.currentState!.validate()) {
                                // Memanggil validate sebelum menavigasi
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Sudah Punya Akun ?'),
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
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Image.asset(
                                  ImageAssets.logoGoogle,
                                  height: 24,
                                ),
                                const Center(
                                  child: Text("Daftar Menggunakan Akun Google"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
