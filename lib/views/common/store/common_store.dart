import 'package:agrolyn/providers/common_store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/common/store/detail_common_store.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class CommonStore extends StatelessWidget {
  const CommonStore({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommonStoreNotifier(context: context),
      child: Consumer<CommonStoreNotifier>(
        builder: (context, value, child) => Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: "Belanja Mudah dan Hemat di "),
                                TextSpan(
                                  text: "Agrolyn",
                                  style: TextStyle(
                                    color: Colors.green,
                                    decorationColor: Colors.green,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "Dapatkan Penawaran Terbaik dari Kami",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.primaryColorDark,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Animasi Lottie
                                  SizedBox(
                                    height: 256,
                                    width: 256,
                                    child: Lottie.asset(ImageAssets.trcuk),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Belanja Cepat dan Mudah",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, bottom: 8, top: 8),
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            alignment: Alignment
                                                .center, // Posisikan teks di tengah
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                            child: const Text(
                                              "Belanja",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
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
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Cari barang disini',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          value.products.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.products.length,
                                  itemBuilder: (context, index) {
                                    var product = value.products[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 100, // Tinggi container
                                        width: double
                                            .infinity, // Lebar mengikuti layar
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              16), // Sudut melengkung
                                          border: Border.all(
                                              color: Colors.green,
                                              width: 1), // Border hijau
                                        ),
                                        child: Row(
                                          children: [
                                            // Gambar di sisi kiri
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: product['img_product'] !=
                                                          null &&
                                                      product['img_product']
                                                          .isNotEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12), // Sudut melengkung gambar
                                                      child: Image.network(
                                                        product['img_product'],
                                                        width: 88,
                                                        height: 88,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : const Text(
                                                      "img produk not available"),
                                            ),
                                            const SizedBox(width: 8),
                                            // Teks di sisi kanan
                                            Expanded(
                                              flex:
                                                  2, // Menyesuaikan proporsi teks
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Nama menu
                                                  Text(
                                                    "${product['product_name']}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 0),
                                                  // Deskripsi
                                                  Text(
                                                    "${product['desc_product']}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  // Harga
                                                  Text(
                                                    "${product['price']}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Tombol belanja
                                            InkWell(
                                              onTap: () {
                                                pushWithoutNavBar(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailCommonStore(
                                                                product:
                                                                    product)));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Container(
                                                  height: 40,
                                                  width:
                                                      80, // Lebar tetap untuk tombol
                                                  alignment: Alignment
                                                      .center, // Posisikan teks di tengah
                                                  decoration: BoxDecoration(
                                                    color: MyColors
                                                        .primaryColorDark, // Warna tombol
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8), // Sudut melengkung
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        offset:
                                                            const Offset(0, 4),
                                                        blurRadius: 8,
                                                      ),
                                                    ],
                                                  ),
                                                  child: const Text(
                                                    "Belanja",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .white, // Warna teks
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: Text("No Product available"),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
