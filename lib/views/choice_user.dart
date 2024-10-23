import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/auth/login_screen.dart';
import 'package:agrolyn/views/auth/register_screen.dart';
import 'package:flutter/material.dart';

class ChoiceUser extends StatelessWidget {
  const ChoiceUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyColors.primaryColor, MyColors.secondaryColor])),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.logo,
                  height: 192,
                  width: 192,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Pilih Ingin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 2),
                Text(
                  "Daftar Sebagai Apa?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.secondaryColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Image.asset(
                                ImageAssets.petani,
                                height: 160,
                                width: 160,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "PETANI",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                  height: 24), // Jarak antara gambar dan teks
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 16),
                              Image.asset(
                                ImageAssets.user2,
                                height: 160,
                                width: 160,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "PENGGUNA BIASA",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                  height: 24), // Jarak antara gambar dan teks
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
