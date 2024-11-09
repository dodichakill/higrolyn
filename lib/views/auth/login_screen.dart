import 'package:agrolyn/providers/login_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/auth/register_screen.dart';
import 'package:agrolyn/views/home/home_page.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(context: context),
      child: Consumer<LoginNotifier>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
            body: Form(
              key: value.keyfrom,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                ImageAssets.logo,
                                height: 192,
                                width: 192,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Agrolyn',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.primaryColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Silahkan Masuk untuk melanjutkan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
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
                                  return "Email Tidak Boleh Kosong";
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
                                  return "Password Tidak Boleh Kosong";
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
                              'Masuk',
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
                              const Text('Belum Punya Akun ?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()),
                                  );
                                },
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Menu()));
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
                                  child: Text("Masuk Menggunakan Akun Google"),
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
