import 'package:agrolyn/providers/common_store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/common/order/common_order.dart';
import 'package:agrolyn/views/common/store/detail_common_store.dart';
import 'package:agrolyn/views/farmer/store/store.dart';
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
                                          "Kelola Toko Anda dengan Mudah",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => pushWithoutNavBar(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Store(),
                                            ),
                                          ),
                                          child: Padding(
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
                                                "Kelola",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.primaryColorDark,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("Lihat Pesanan Kamu Yuk!",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Lottie.asset(ImageAssets.proses),
                                  ),
                                  InkWell(
                                    onTap: () => pushWithoutNavBar(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CommonOrder(),
                                      ),
                                    ),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.white, size: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            child: value.products.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: value.products.length,
                                    itemBuilder: (context, index) {
                                      var product = value.products[index];
                                      return Container(
                                        margin: const EdgeInsets.all(
                                            4), // Jarak antara card
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .white, // Warna latar belakang
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 6,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Gambar thumbnail
                                            product['img_product'] != null &&
                                                    product['img_product']
                                                        .isNotEmpty
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      product['img_product'],
                                                      width: 120,
                                                      height: 130,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : const Text(
                                                    "img produk not available"),
                                            const SizedBox(width: 12),
                                            // Kolom untuk teks
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Judul
                                                  Text(
                                                    "${product['product_name']}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "${product['desc_product']}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "Rp. ${product['price']}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  // Detail informasi
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween, // Menjauhkan kedua elemen ke kiri dan kanan
                                                    children: [
                                                      // Row untuk kategori produk
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                              Icons.fastfood,
                                                              size: 14,
                                                              color:
                                                                  Colors.grey),
                                                          const SizedBox(
                                                              width: 4),
                                                          Text(
                                                            "${product['product_categories_id'] == 1 ? 'Mentah' : (product['product_categories_id'] == 2 ? 'Olahan' : 'Lainnya')}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Menampilkan data pada sisi kanan
                                                      InkWell(
                                                        onTap: () {
                                                          pushWithoutNavBar(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailCommonStore(
                                                                      product:
                                                                          product),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width:
                                                              120, // Lebar tetap untuk tombol
                                                          alignment: Alignment
                                                              .center, // Posisikan teks di tengah
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MyColors
                                                                .primaryColorDark, // Warna tombol
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Sudut melengkung
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                                offset:
                                                                    const Offset(
                                                                        0, 4),
                                                                blurRadius: 8,
                                                              ),
                                                            ],
                                                          ),
                                                          child: const Text(
                                                            "Lihat",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white, // Warna teks
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text("No Product available"),
                                  ),
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
