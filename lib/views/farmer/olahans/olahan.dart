import 'package:agrolyn/providers/detail_olahan_notifier.dart';
import 'package:agrolyn/providers/olahans_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/widgets/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Olahan extends StatelessWidget {
  final int id;
  const Olahan({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailOlahanNotifier(id, context: context),
      child: Consumer<DetailOlahanNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            onTap: () => Navigator.pop(
                                context), // Kembali ke halaman sebelumnya
                            child: const Row(children: [
                              Icon(Icons.arrow_back),
                              SizedBox(
                                width: 22,
                              ),
                              Text("Kembali", style: TextStyle(fontSize: 20)),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 5)
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  // Thumbnail image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: value.detailOlahans['thumbnail'] !=
                                                null &&
                                            value.detailOlahans['thumbnail']
                                                .isNotEmpty
                                        ? Image.network(
                                            value.detailOlahans['thumbnail'] ??
                                                '',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 256,
                                          )
                                        : const Icon(Icons.image, size: 64),
                                  ),
                                  const SizedBox(height: 16),
                                  // Dish title
                                  Text(
                                    "${value.detailOlahans['title'] ?? 'Unknownn'}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  // Dish title
                                  Text(
                                    "${value.detailOlahans['description'] ?? 'Unknown'}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Bahan-bahan membuat ${value.detailOlahans['title'] ?? 'Unknownn'}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  // Dish title
                                  Text(
                                    "${value.detailOlahans['ingredients'] ?? 'Unknown'}",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        value.detailOlahans.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 280,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColorDark,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors
                                                    .white, // Warna lingkaran kecil
                                              ),
                                            ),
                                            // Garis atas
                                            Container(
                                              width: 4,
                                              height: 30, // Panjang garis atas
                                              color: Colors.grey,
                                            ),
                                            // Lingkaran dengan angka
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors
                                                    .white, // Warna lingkaran
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '', // Angka di dalam lingkaran
                                                style: TextStyle(
                                                  color: Colors
                                                      .white, // Warna teks
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            // Garis bawah
                                            Container(
                                              width: 2,
                                              height: 30, // Panjang garis bawah
                                              color: Colors.grey,
                                            ),
                                            // Lingkaran kecil di bawah
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors
                                                    .white, // Warna lingkaran kecil
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Title
                                              Text(
                                                "Langkah-langkah dalam pembuatan ${value.detailOlahans['title'] ?? 'Unknownn'}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "${value.detailOlahans['steps'] ?? 'Unknown'}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: NoFoundCustom(
                                  message: "Olahan Tidak Ditemukan",
                                  subMessage:
                                      "Olahan yang kamu cari tidak ditemukan!",
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    )
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
