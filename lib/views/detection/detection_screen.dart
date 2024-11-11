import 'package:agrolyn/providers/detection_notifier.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/card_scan_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetectionNotifier(context: context),
      child: Consumer<DetectionNotifier>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 70),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Image.asset(ImageAssets.bannerScan),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Deteksi Penyakit Tanaman",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black)),
                    const SizedBox(
                      height: 20,
                    ),
                    const CardScanType(
                      title: "Scan Tanaman Jagung",
                      image: ImageAssets.logoJagung,
                    ),
                    const CardScanType(
                      title: "Scan Tanaman Padi",
                      image: ImageAssets.logoPadi,
                    ),
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}
