import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/providers/home_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/utils/date.dart';
import 'package:agrolyn/views/chatbot/chatbot.dart';
import 'package:agrolyn/views/farmer/home/detail_article.dart';
import 'package:agrolyn/widgets/all_article_screen.dart';
import 'package:agrolyn/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    initialize();
  }

  void initialize() async {
    String? res = await AuthService().refreshToken();
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        final weather = value.weathers.isNotEmpty ? value.weathers.first : null;

        return SafeArea(
          bottom: false,
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
                                  top: 8, bottom: 0, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    height: 0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Selamat Datang Di Agrolyn",
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            "Solusi Cerdas Pertanian Masa Depan",
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Lottie.asset(ImageAssets.videos,
                                          height: 92, width: 92),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
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
                                              fontSize: 16,
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
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Divider(
                                              thickness: 3,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Suhu saat ini ${weather['temp']}°C",
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    // Animasi Lottie
                                    SizedBox(
                                      height: 192,
                                      width: 192,
                                      child: weather['temp'] < 28
                                          ? Lottie.asset(
                                              ImageAssets
                                                  .cloudy, // Ganti dengan path animasi hujan
                                              width: 222,
                                              height: 222,
                                              fit: BoxFit.fill,
                                            )
                                          : Lottie.asset(
                                              ImageAssets
                                                  .cloud, // Ganti dengan path animasi cerah
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllArticleScreen()),
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
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: value.articles.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, left: 0),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          var article = value.articles[index];
                                          return InkWell(
                                              onTap: () {
                                                pushWithoutNavBar(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailArticle(
                                                            article: article),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, bottom: 8, right: 8),
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
                                      "Video Edukasi",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white, // Menambahkan warna teks agar kontras
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllArticleScreen()),
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
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                final video = value.videos[index];

                                return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 16), // Atur jarak antar video
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
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
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                        child: Image.network(
                                          video['thumbnail'],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 150,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Judul video
                                            Text(
                                              video['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            // Deskripsi video
                                            Text(
                                              video['description'],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
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
                                                width: double.infinity,
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
                                                  "Lihat",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 138,
                        left: 8,
                        right: 8,
                        child: SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // Mengatur scroll horizontal
                          child: Row(
                            children: [
                              // Container pertama
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Padding di dalam container
                                height:
                                    64, // Menyesuaikan tinggi supaya lebih proporsional
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    )
                                  ],
                                  border: Border.all(
                                    color: MyColors.primaryColorDark.withOpacity(
                                        0.3), // Border dengan warna lebih menarik
                                    width: 1.5, // Lebar border yang pas
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Rata kiri untuk elemen pertama
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.logoPadi,
                                      height: 32,
                                      width: 32,
                                    ),
                                    const SizedBox(
                                        width:
                                            12), // Ruang antara gambar dan teks
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Padi",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .w600, // Font lebih tebal
                                          ),
                                        ),
                                        Text(
                                          "Augmented Reality",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black.withOpacity(
                                                0.7), // Warna lebih lembut
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              // Container kedua
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Padding di dalam container
                                height:
                                    64, // Menyesuaikan tinggi supaya lebih proporsional
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    )
                                  ],
                                  border: Border.all(
                                    color: MyColors.primaryColorDark.withOpacity(
                                        0.3), // Border dengan warna lebih menarik
                                    width: 1.5, // Lebar border yang pas
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Rata kiri untuk elemen pertama
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.logoJagung,
                                      height: 32,
                                      width: 32,
                                    ),
                                    const SizedBox(
                                        width:
                                            12), // Ruang antara gambar dan teks
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Jagung",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .w600, // Font lebih tebal
                                          ),
                                        ),
                                        Text(
                                          "Augmented Reality",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black.withOpacity(
                                                0.7), // Warna lebih lembut
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              // Container ketiga
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Padding di dalam container
                                height:
                                    64, // Menyesuaikan tinggi supaya lebih proporsional
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    )
                                  ],
                                  border: Border.all(
                                    color: MyColors.primaryColorDark.withOpacity(
                                        0.3), // Border dengan warna lebih menarik
                                    width: 1.5, // Lebar border yang pas
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Rata kiri untuk elemen pertama
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.chili,
                                      height: 32,
                                      width: 32,
                                    ),
                                    const SizedBox(
                                        width:
                                            12), // Ruang antara gambar dan teks
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cabai",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .w600, // Font lebih tebal
                                          ),
                                        ),
                                        Text(
                                          "Augmented Reality",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black.withOpacity(
                                                0.7), // Warna lebih lembut
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              // Container keempat
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Padding di dalam container
                                height:
                                    64, // Menyesuaikan tinggi supaya lebih proporsional
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    )
                                  ],
                                  border: Border.all(
                                    color: MyColors.primaryColorDark.withOpacity(
                                        0.3), // Border dengan warna lebih menarik
                                    width: 1.5, // Lebar border yang pas
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Rata kiri untuk elemen pertama
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.tomato,
                                      height: 32,
                                      width: 32,
                                    ),
                                    const SizedBox(
                                        width:
                                            12), // Ruang antara gambar dan teks
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tomat",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .w600, // Font lebih tebal
                                          ),
                                        ),
                                        Text(
                                          "Augmented Reality",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black.withOpacity(
                                                0.7), // Warna lebih lembut
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: value.chatbotPosition.dx,
                  top: value.chatbotPosition.dy,
                  child: Draggable(
                    feedback: Image.asset(
                      ImageAssets.logoChatbot,
                      height: 80,
                      width: 80,
                    ),
                    childWhenDragging:
                        Container(), // Widget shown when dragging
                    onDraggableCanceled: (velocity, offset) {
                      // Update position using the provider
                      value.updateChatbotPosition(offset);
                    },
                    child: InkWell(
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
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
