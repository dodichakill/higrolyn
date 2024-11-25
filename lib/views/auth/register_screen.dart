import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/providers/register_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  child: Lottie.asset(
                    ImageAssets.backgorundAnimation1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Form(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32, right: 16, left: 16, bottom: 16),
                    child: Center(
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
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Daftar',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: value.nameController,
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
                                  return null;
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
                                controller: value.emailController,
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
                                  return null;
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          // Section: Phone Number Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: value.phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Nomor Hp',
                                  prefix: const Text('+62 '),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: value.addressController,
                                decoration: InputDecoration(
                                  labelText: 'Alamat',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "Alamat Tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Section: Password Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: value.passwordController,
                                obscureText: true,
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
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Section: Confirm Password Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: value.retypePasswordController,
                                obscureText: true,
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
                              onPressed: () async {
                                value.setLoading(true);

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String? id = prefs.getString('role_choice');
                                print(
                                    "${int.parse(id ?? '0')} ${value.nameController.text} ${value.emailController.text} ${value.phoneController.text} ${value.addressController.text} ${value.passwordController.text}");
                                // if (value.keyfrom.currentState!.validate()) {
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {},
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
                                    child:
                                        Text("Daftar Menggunakan Akun Google"),
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
            ],
          ),
        ),
      ),
    );
  }
}
