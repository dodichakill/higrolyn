import 'package:agrolyn/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DataNotFound extends StatelessWidget {
  final String title;
  final String subtitle;

  // Konstruktor untuk menerima parameter judul dan subjudul
  DataNotFound({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan animasi Lottie
            Lottie.asset(
              ImageAssets.notFound404,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // Menampilkan judul
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            // Menampilkan subjudul
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
