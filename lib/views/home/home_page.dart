import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: MyColors.primaryColorDark,
                        width: double.infinity,
                        height: 168,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    ImageAssets.logo,
                                    height: 32,
                                    width: 32,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.sunny,
                                        color: Colors.yellow[600],
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        "35°C",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "|",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        "Tegal, Jawa Tengah",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Selamat Datang Di Agrolyn",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Bangkit bersama untuk mengatasi krisis pangan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 54,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                        child: SizedBox(
                          height: 256,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: PageView(
                              children: [
                                Image.asset(ImageAssets.banner1,
                                    fit: BoxFit.cover),
                                Image.asset(ImageAssets.banner2,
                                    fit: BoxFit.cover),
                                Image.asset(ImageAssets.banner3,
                                    fit: BoxFit.cover),
                                Image.asset(ImageAssets.banner4,
                                    fit: BoxFit.cover),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, bottom: 8, right: 8),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColorDark,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Belanja",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // Menambahkan warna teks agar kontras
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Lihat lainnya",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors
                                          .white, // Mengubah warna teks menjadi putih
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    child: Image.asset(
                                      height: 100,
                                      width: 200,
                                      ImageAssets.jagung,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text(
                                    "Jasuke",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.label,
                                        size: 12,
                                      ),
                                      Text(
                                        "Makanan Olahan",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    child: Image.asset(
                                      height: 100,
                                      width: 200,
                                      ImageAssets.jagung,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text(
                                    "Jasuke",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.label,
                                        size: 12,
                                      ),
                                      Text(
                                        "Makanan Olahan",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    child: Image.asset(
                                      height: 100,
                                      width: 200,
                                      ImageAssets.jagung,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text(
                                    "Jasuke",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.label,
                                        size: 12,
                                      ),
                                      Text(
                                        "Makanan Olahan",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    child: Image.asset(
                                      height: 100,
                                      width: 200,
                                      ImageAssets.jagung,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text(
                                    "Jasuke",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.label,
                                        size: 12,
                                      ),
                                      Text(
                                        "Makanan Olahan",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, bottom: 8, right: 8),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColorDark,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Artikel",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // Menambahkan warna teks agar kontras
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Lihat lainnya",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors
                                          .white, // Mengubah warna teks menjadi putih
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(ImageAssets.jagung),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Cara nanam padi yang baik & benar"),
                                    Text("Lorem Ipsum"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(ImageAssets.jagung),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Cara nanam padi yang baik & benar"),
                                    Text("Lorem Ipsum"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(ImageAssets.jagung),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Cara nanam padi yang baik & benar"),
                                    Text("Lorem Ipsum"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 138,
                    left: 8,
                    right: 8,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(4),
                          height: 64,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(2, 2),
                                )
                              ],
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImageAssets.logoPadi,
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Padi",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Augmented Reality",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(4),
                          height: 64,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(2, 2),
                                )
                              ],
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImageAssets.logoJagung,
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jagung",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Augmented Reality",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 775,
                left: 8,
                right: 8,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          ImageAssets.logoChatbot,
                          height: 80,
                          width: 80,
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
