import 'package:agrolyn/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoFoundCustom extends StatelessWidget {
  final String message; // Pesan kustom yang ingin ditampilkan
  final String subMessage; // Sub pesan yang menjelaskan lebih lanjut

  const NoFoundCustom({
    super.key,
    this.message = "No Result Found", // Default pesan
    this.subMessage =
        "We can’t find any item matching your search", // Default sub pesan
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar (bisa menggunakan image asset atau lottie animation)
              Lottie.asset(
                ImageAssets.notFound404baru,
                width: 222,
                height: 222,
              ),
              const SizedBox(height: 16),
              // Pesan Utama
              Text(message,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF4A4A4A),
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Google Sans")),
              const SizedBox(height: 8),
              // Sub Pesan
              Text(
                subMessage,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4A4A),
                    height: 1.5,
                    fontFamily: "Roboto"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}

class NoFoundCustomWhite extends StatelessWidget {
  final String message; // Pesan kustom yang ingin ditampilkan
  final String subMessage; // Sub pesan yang menjelaskan lebih lanjut

  const NoFoundCustomWhite({
    super.key,
    this.message = "No Result Found", // Default pesan
    this.subMessage =
        "We can’t find any item matching your search", // Default sub pesan
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar (bisa menggunakan image asset atau lottie animation)
              Lottie.asset(
                ImageAssets.error,
                width: 222,
                height: 222,
              ),
              const SizedBox(height: 16),
              // Pesan Utama
              Text(message,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      fontFamily: "Google Sans")),
              const SizedBox(height: 8),
              // Sub Pesan
              Text(
                subMessage,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.5,
                    fontFamily: "Roboto"),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
