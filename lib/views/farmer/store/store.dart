import 'package:agrolyn/providers/store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/common/store/detail_common_store.dart';
import 'package:agrolyn/views/farmer/store/edit_product.dart';
import 'package:agrolyn/views/farmer/store/form_product.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class Store extends StatelessWidget {
  Map<String, dynamic> product = {};
  Store({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(
        builder: (context, value, child) => SafeArea(
          bottom: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: MyColors.primaryColorDark,
                        width: double.infinity,
                        height: 256, // Menyediakan ruang yang cukup
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32, bottom: 8, left: 16, right: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          onChanged: (query) {
                                            if (query.length > 2) {
                                              value.searchProduct(query);
                                            } else {
                                              value.fetchProduct();
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "Cari produk...",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            prefixIcon: Icon(Icons.search,
                                                color: Colors.grey),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 20.0),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(width: 8),
                                  ClipOval(
                                    child: Image.asset(
                                      ImageAssets.logo,
                                      height: 48,
                                      width: 48,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Baru! AgrolynShop Hemat Mulai dari 5 ribu, lho!, Cepat dan Fresh Pastinya",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Lottie.asset(
                                          ImageAssets.vegetables,
                                          fit: BoxFit.cover,
                                          height: 128,
                                          width: 128)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: value.products.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                        borderRadius: BorderRadius.circular(16),
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
                                      child: Column(
                                        children: [
                                          Row(
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
                                                        width: 100,
                                                        height: 100,
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
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
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
                                                    const SizedBox(
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
                                                          CrossAxisAlignment
                                                              .end,
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
                                                                color: Colors
                                                                    .grey),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              product['product_categories_id'] ==
                                                                      1
                                                                  ? 'Mentah'
                                                                  : (product['product_categories_id'] ==
                                                                          2
                                                                      ? 'Olahan'
                                                                      : 'Lainnya'),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Menampilkan data pada sisi kanan
                                              InkWell(
                                                onTap: () {
                                                  pushWithoutNavBar(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailCommonStore(
                                                              product: product),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.265,
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
                                                    "Detail",
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

                                              // Menampilkan data pada sisi kanan
                                              InkWell(
                                                onTap: () {
                                                  pushWithoutNavBar(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProduct(
                                                        product: product,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.265,
                                                  alignment: Alignment
                                                      .center, // Posisikan teks di tengah
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow[
                                                        800], // Warna tombol
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
                                                    "Edit",
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

                                              // Menampilkan data pada sisi kanan
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Konfirmasi'),
                                                          content: const Text(
                                                              'Apakah Anda yakin ingin menghapus produk ini?'),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  'Batal'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  'Hapus'),
                                                              onPressed: () {
                                                                value.deleteProduct(
                                                                    product[
                                                                        'id']);
                                                                showCustomSnackbar(
                                                                    context,
                                                                    "Berhasil dihapus",
                                                                    "Produk Berhasil dihapus",
                                                                    ContentType
                                                                        .success);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.265,
                                                  alignment: Alignment
                                                      .center, // Posisikan teks di tengah
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .red, // Warna tombol
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
                                                    "Hapus",
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
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("No Product available"),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 224,
                    left: 8,
                    right: 8,
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
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImageAssets.logo,
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(width: 8),
                                  const Flexible(
                                    child: Text(
                                      "Ayo mulai jadi mitra kami",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await pushWithoutNavBar(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FormProduct(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 136, // Lebar tetap untuk tombol
                                alignment: Alignment
                                    .center, // Posisikan teks di tengah
                                decoration: BoxDecoration(
                                  color:
                                      MyColors.primaryColorDark, // Warna tombol
                                  borderRadius: BorderRadius.circular(
                                      8), // Sudut melengkung
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  "Tambah Produk",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Warna teks
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
