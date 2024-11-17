import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Deeplink {
  static toPlaystore(context) async {
    const String packageName =
        "com.peat.GartenBank"; // Ganti dengan ID aplikasi Anda
    final Uri marketUri = Uri.parse("market://details?id=$packageName");
    final Uri playStoreUri =
        Uri.parse("https://play.google.com/store/apps/details?id=$packageName");

    try {
      // Coba buka Play Store dengan URI market://
      if (await canLaunchUrl(marketUri)) {
        await launchUrl(marketUri, mode: LaunchMode.externalApplication);
      } else {
        // Jika gagal, gunakan fallback ke HTTP URL
        if (await canLaunchUrl(playStoreUri)) {
          await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Tidak dapat membuka halaman Play Store",
                  style: TextStyle(color: Colors.white),
                )),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
