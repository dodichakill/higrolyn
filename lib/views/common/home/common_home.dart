import 'package:agrolyn/utils/date.dart';
import 'package:agrolyn/views/common/store/detail_common_store.dart';
import 'package:agrolyn/views/farmer/home/detail_article.dart';
import 'package:agrolyn/widgets/all_article_screen.dart';
import 'package:agrolyn/widgets/data_not_found.dart';
import 'package:agrolyn/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:agrolyn/providers/common_home_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/chatbot/chatbot.dart';
import 'package:lottie/lottie.dart';

class CommonHome extends StatelessWidget {
  const CommonHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CommonHomeNotifier(context: context),
        child: Consumer<CommonHomeNotifier>(
          builder: (context, value, child) {
            final weather =
                value.weathers.isNotEmpty ? value.weathers.first : null;

            return Scaffold(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageAssets.logo,
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(width: 8),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "AGROLYN",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.primaryColor),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Solusi Pertanian Masa Depan",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  pushWithoutNavBar(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Chatbot(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  ImageAssets.logoChatbot,
                                  height: 56,
                                  width: 56,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        value.weathers.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16,
                                        left: 40,
                                        bottom: 16,
                                        right: 16),
                                    child: Column(
                                      children: [
                                        Text(
                                          weather != null
                                              ? "${weather['temp']}°C"
                                              : "Suhu saat ini tidak tersedia",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40,
                                          ),
                                        ),
                                        Text(
                                          "${weather['city']}, ${weather['country']}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const Text("No weather data available"),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 226,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.primaryColorDark,
                            ),
                            child: Row(
                              children: [
                                // Animasi Lottie
                                SizedBox(
                                  height: 256,
                                  width: 256,
                                  child: Lottie.asset(ImageAssets.vegetables),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Bigung Cari Kebutuhan Dapur Yang Segar ?",
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 8, bottom: 8, right: 8),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColorDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: SizedBox(
                            height:
                                314, // Memberi tinggi tetap untuk ListView agar layout rapi
                            child: value.isLoading
                                ? CircularProgressIndicator() // Tampilkan indikator loading saat isLoading
                                : value.products.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis
                                            .horizontal, // Arah scroll horizontal
                                        itemCount: value
                                            .products.length, // Jumlah item
                                        itemBuilder: (context, index) {
                                          var product = value.products[index];
                                          return InkWell(
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
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8), // Jarak antar item
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  product['img_product'] !=
                                                              null &&
                                                          product['img_product']
                                                              .isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10), // Sudut melengkung
                                                          child: Image.network(
                                                            product[
                                                                'img_product'],
                                                            fit: BoxFit.cover,
                                                            height: 180,
                                                            width: 160,
                                                          ),
                                                        )
                                                      : const Text(
                                                          "img produk not available"),
                                                  const SizedBox(height: 8),
                                                  // Nama produk
                                                  Text(
                                                    "${product['product_name']}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  // Harga produk
                                                  Text(
                                                    "${product['price']}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  // Kategori atau desskripsi
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.fastfood,
                                                          size: 16,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        "${product['product_categories_id'] == 1 ? "Mentah" : (product['product_categories_id'] == 2 ? "Olahan" : "Lainnya")}",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
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
                                                      decoration: BoxDecoration(
                                                        color: MyColors
                                                            .primaryColorDark, // Warna tombol
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8), // Sudut melengkung
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
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
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .white, // Warna teks
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Text("img produk not available"),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 226,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.primaryColorDark,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 8, top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Baca Artikel dan Video Edukasi yang menarik disini",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AllArticleScreen()),
                                            );
                                          },
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
                                              "Selengkapnya",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: MyColors
                                                      .primaryColorDark),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Animasi Lottie
                                  SizedBox(
                                    height: 192,
                                    width: 192,
                                    child: Lottie.asset(ImageAssets.article),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8, left: 8, right: 8),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColorDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    onPressed: () {
                                      pushWithoutNavBar(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AllArticleScreen(),
                                        ),
                                      );
                                    },
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
                        value.isLoading
                            ? CircularProgressIndicator()
                            : value.articles.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          var article = value.articles[
                                              index]; // Mengambil artikel yang dipilih
                                          return InkWell(
                                              onTap: () {
                                                pushWithoutNavBar(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailArticle(
                                                      article:
                                                          article, // Mengirim artikel yang dipilih ke halaman detail
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                margin: const EdgeInsets.only(
                                                    bottom:
                                                        8), // Memberikan sedikit jarak antar artikel
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 6,
                                                      spreadRadius: 2,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    // Gambar thumbnail
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        article['thumbnail'],
                                                        height: 100,
                                                        width: 70,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    // Kolom untuk teks (kategori, judul, waktu)
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  size: 11,
                                                                  color: Colors
                                                                      .grey),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                "${article['location']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 2),
                                                          Text(
                                                            "${article['title']}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            "${article['description']}",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons
                                                                      .calendar_month_outlined,
                                                                  size: 11,
                                                                  color: Colors
                                                                      .grey),
                                                              const SizedBox(
                                                                  width: 4),
                                                              FutureBuilder(
                                                                future: formatRelativeTime(
                                                                    article[
                                                                        "released_date"]),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    return Text(
                                                                      snapshot
                                                                          .data
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return const CircularProgressIndicator(); // or some other loading indicator
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                        }),
                                  )
                                : const Center(
                                    child: Text("No articles available"),
                                  ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColorDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Video Edukasi",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      pushWithoutNavBar(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AllArticleScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Lihat lainnya",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8), // Jarak kecil antar elemen
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: value.isLoading
                                ? CircularProgressIndicator()
                                : value.videos.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          final video = value.videos[index];

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    8), // Atur jarak antar video
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5,
                                                  spreadRadius: 2,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Thumbnail video
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                  ),
                                                  child: Image.network(
                                                    video['thumbnail'],
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 150,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Judul video
                                                      Text(
                                                        video['title'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      // Deskripsi video
                                                      Text(
                                                        video['description'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),

                                                      InkWell(
                                                        onTap: () {
                                                          showVideoDialog(
                                                            context,
                                                            video['link_yt'],
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width:
                                                              double.infinity,
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text("No videos available"),
                                      ))
                      ],
                    ),
                    Positioned(
                      top: 82,
                      right: 0,
                      child: value.isLoading
                          ? CircularProgressIndicator() // Tampilkan indikator loading saat isLoading
                          : weather == null
                              ? DataNotFound(
                                  title: "Data Tidak Ditemukan",
                                  subtitle: "Data cuaca tidak ditemukan",
                                )
                              : SizedBox(
                                  height: 192,
                                  width: 192,
                                  child: weather['temp'] < 28
                                      ? Lottie.asset(
                                          ImageAssets
                                              .cloudy, // Ganti dengan path animasi hujan
                                          fit: BoxFit.fill,
                                        )
                                      : Lottie.asset(
                                          ImageAssets
                                              .cloud, // Ganti dengan path animasi cerah
                                          fit: BoxFit.fill,
                                        ),
                                ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
