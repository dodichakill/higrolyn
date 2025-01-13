import 'package:agrolyn/providers/detection_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/detection/history_scan_screen.dart';
import 'package:agrolyn/widgets/card_scan_type.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
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
                      title: "Jagung",
                      image: ImageAssets.logoJagung,
                    ),
                    const CardScanType(
                      title: "Padi",
                      image: ImageAssets.logoPadi,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          pushWithoutNavBar(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HistoryScanScreen()));
                        },
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          alignment:
                              Alignment.center, // Posisikan teks di tengah
                          decoration: BoxDecoration(
                            color: MyColors.primaryColorDark,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Text(
                            "Lihat Riwayat Scan Tanaman",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}
