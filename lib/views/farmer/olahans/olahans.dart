import 'package:agrolyn/providers/olahans_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/olahans/olahan.dart';
import 'package:agrolyn/widgets/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Olahans extends StatelessWidget {
  final int idCat;
  const Olahans({super.key, required this.idCat});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OlahansNotifier(idCat, context: context),
      child: Consumer<OlahansNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
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
                      padding: const EdgeInsets.all(8.0),
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
                            SizedBox(
                                height: 256,
                                width: 256,
                                child: Lottie.asset(ImageAssets.chef)),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                ), // Jumlah kolom
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    value.detailOlahans.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 5 / 2.3,
                            ),
                            itemCount: value.detailOlahans.length,
                            itemBuilder: (context, index) {
                              var detailOlahan = value.detailOlahans[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColorDark,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            detailOlahan['thumbnail'] != null &&
                                                    detailOlahan['thumbnail']
                                                        .isNotEmpty
                                                ? ClipOval(
                                                    child: Image.network(
                                                      detailOlahan[
                                                              'thumbnail'] ??
                                                          '',
                                                      fit: BoxFit.cover,
                                                      width: 128,
                                                      height: 128,
                                                    ),
                                                  )
                                                : const Icon(Icons.image,
                                                    size: 64),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${detailOlahan['title']}",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${detailOlahan['description']}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  InkWell(
                                                    onTap: () {
                                                      int id = int.tryParse(
                                                              detailOlahan['id']
                                                                  .toString()) ??
                                                          0;
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Olahan(id: id),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 32,
                                                      width: 160,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: const Center(
                                                        child: Text(
                                                          "Lihat Selengkapnya",
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .primaryColorDark,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
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
