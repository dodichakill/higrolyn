import 'dart:ui';
import 'package:agrolyn/providers/common_store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/views/transaction/detail_transaction.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailCommonStore extends StatelessWidget {
  final Map<String, dynamic> product;
  const DetailCommonStore({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommonStoreNotifier(context: context),
      child: Consumer<CommonStoreNotifier>(
        builder: (context, value, child) => Scaffold(
          body: Stack(
            children: [
              // Bagian gambar header
              Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        product['img_product'],
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 40,
                        left: 16,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 24,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Bagian kontainer detail
              Positioned(
                top: 196,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul dan tombol favorit
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${product['product_name']}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.fastfood,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    product['product_categories_id'] == 1
                                        ? 'Mentah'
                                        : (product['product_categories_id'] == 2
                                            ? 'Olahan'
                                            : 'Lainnya'),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Rp. ${product['price']}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Petunjuk (instructions)
                          const Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${product['desc_product']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          // Bahan-bahan (ingredients)
                          const Text(
                            'Terjual',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Total ${product['sold']} terjual",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          // Bahan-bahan (ingredients)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'Stock Barang',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${product['stock']} stok di gudang",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  // Menampilkan gallery gambar dalam popup dengan ukuran tertentu
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Sudut melengkung
                                      ),
                                      child: SizedBox(
                                        width:
                                            350, // Menentukan lebar popup (ubah sesuai kebutuhan)
                                        height:
                                            400, // Menentukan tinggi popup (ubah sesuai kebutuhan)
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              12), // Sudut melengkung
                                          child: PhotoViewGallery.builder(
                                            itemCount:
                                                3, // Jumlah gambar yang ingin ditampilkan
                                            builder: (context, index) {
                                              List<String> imageUrls = [
                                                product['img_product'],
                                                product['img_product'],
                                                product['img_product'],
                                              ];
                                              return PhotoViewGalleryPageOptions(
                                                imageProvider: NetworkImage(
                                                    imageUrls[index]),
                                                minScale: PhotoViewComputedScale
                                                    .contained,
                                                maxScale: PhotoViewComputedScale
                                                    .covered,
                                              );
                                            },
                                            scrollPhysics:
                                                const BouncingScrollPhysics(),
                                            backgroundDecoration:
                                                const BoxDecoration(
                                                    color: Colors.white),
                                            pageController: PageController(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 120, // Lebar tetap untuk tombol
                                  alignment: Alignment
                                      .center, // Posisikan teks di tengah
                                  decoration: BoxDecoration(
                                    color: MyColors
                                        .primaryColorDark, // Warna tombol
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
                                    "Lihat",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // Warna teks
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // Gambar dengan Zoom & Swipe Gallery
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              height: 256,
                              width: double.infinity,
                              product['img_product'],
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 24),
                          // Tombol hijau
                          value.role == "3"
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: () {
                                      pushWithoutNavBar(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DetailTransaction(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Beli Sekarang',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),

                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoViewGalleryPage extends StatelessWidget {
  final List<String> imageUrls;
  const PhotoViewGalleryPage({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery(
        pageOptions: imageUrls.map((url) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        }).toList(),
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        enableRotation: true,
      ),
    );
  }
}
