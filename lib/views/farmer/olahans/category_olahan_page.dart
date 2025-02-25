import 'package:agrolyn/providers/olahans_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/olahans/olahans.dart';
import 'package:agrolyn/widgets/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CategoryOlahanPage extends StatelessWidget {
  final int idCat;
  const CategoryOlahanPage({super.key, required this.idCat});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OlahansNotifier(idCat, context: context),
      child: Consumer<OlahansNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () => Navigator.pop(
                            context), // Kembali ke halaman sebelumnya
                        child: Row(children: [
                          const Icon(Icons.arrow_back),
                          const SizedBox(
                            width: 22,
                          ),
                          const Text("Kembali", style: TextStyle(fontSize: 20)),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Container(
                        height: 192,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: MyColors.primaryColorDark),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Mulai Olah Bahan Masak Kamu Jadi Aneka Masakan Nusantara Terpopuler",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            decorationThickness: 2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            SizedBox(
                                height: 230,
                                width: 230,
                                child: Lottie.asset(ImageAssets.chef)),
                          ],
                        ),
                      ),
                    ),
                    // Olahan list horizontal using GridView.builder
                    value.olahans.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 3 / 2.3,
                            ),
                            itemCount: value.olahans.length,
                            itemBuilder: (BuildContext context, int index) {
                              var olahan = value.olahans[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColorDark,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      olahan['thumbnail'] != null &&
                                              olahan['thumbnail'].isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                olahan['thumbnail'] ?? '',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 76,
                                              ),
                                            )
                                          : const Icon(Icons.image, size: 64),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${olahan['label'] ?? 'Unknown'}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                int idCat = int.tryParse(
                                                        olahan['id']
                                                            .toString()) ??
                                                    0;
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Olahans(idCat: idCat),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 32,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Center(
                                                  child: Text(
                                                    "Lihat Selengkapnya",
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .primaryColorDark,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: NoFoundCustom(
                              message: "Olahan Kosong",
                              subMessage:
                                  "Olahan yang kamu cari lagi kosong nih!",
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
