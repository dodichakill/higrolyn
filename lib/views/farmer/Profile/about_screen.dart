import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Aplikasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              ImageAssets.logo,
              height: 130,
              width: 130,
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Agrolyn",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              "Solusi cerdas pertanian masa depan",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Versi 0.1.0",
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                ImageAssets.customerService,
                // height: 130,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Ada kendala dalam menggunakan aplikasi ini?",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColorDark,
                  ),
                  onPressed: () {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'customersupport@agrolyn.online',
                      queryParameters: {
                        'subject': 'Kendala',
                      },
                    );
                    launchUrl(emailLaunchUri);
                  },
                  child: const Text(
                    "Hubungi Customer Support",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
