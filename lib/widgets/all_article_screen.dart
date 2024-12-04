import 'package:agrolyn/providers/home_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/utils/date.dart';
import 'package:agrolyn/views/farmer/home/detail_article.dart';
import 'package:agrolyn/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class AllArticleScreen extends StatelessWidget {
  const AllArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) => DefaultTabController(
          length: 2, // Jumlah tab
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Artikel dan Video Edukasi"),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.article_outlined),
                        const SizedBox(width: 5),
                        Text('Artikel'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_library_outlined),
                        const SizedBox(width: 5),
                        Text('Video'),
                      ],
                    ),
                  ),
                ],
                indicatorColor:
                    MyColors.primaryColorDark, // Warna garis bawah tab aktif
                labelColor: MyColors.primaryColorDark, // Warna teks tab aktif
                unselectedLabelColor: Colors.grey, // Warna teks tab tidak aktif
              ),
            ),
            body: TabBarView(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      ImageAssets.logo,
                                      height: 24,
                                      width: 24,
                                    ),
                                    const SizedBox(width: 4),
                                    Text('Agrolyn',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.primaryColorDark)),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Baca berbagai bacaan menarik tentang pertanian di Agrolyn Artikel",
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Lottie.asset(ImageAssets.article),
                          ),
                        ],
                      ),
                    ),
                    value.articles.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.articles.length,
                                itemBuilder: (context, index) {
                                  var article = value.articles[
                                      index]; // Mengambil artikel yang dipilih
                                  return InkWell(
                                      onTap: () {
                                        pushWithoutNavBar(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailArticle(
                                              article:
                                                  article, // Mengirim artikel yang dipilih ke halaman detail
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12.0),
                                        margin: const EdgeInsets.only(
                                            bottom:
                                                8), // Memberikan sedikit jarak antar artikel
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          children: [
                                            // Gambar thumbnail
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          size: 11,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        "${article['location']}",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "${article['title']}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    "${article['description']}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons
                                                              .calendar_month_outlined,
                                                          size: 11,
                                                          color: Colors.grey),
                                                      const SizedBox(width: 4),
                                                      FutureBuilder(
                                                        future: formatRelativeTime(
                                                            article[
                                                                "released_date"]),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Text(
                                                              snapshot.data
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
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
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Lottie.asset(ImageAssets.videos),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      ImageAssets.logo,
                                      height: 24,
                                      width: 24,
                                    ),
                                    const SizedBox(width: 4),
                                    Text('Agrolyn',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.primaryColorDark)),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  "Tonton berbagai tontonan edukasi menarik tentang pertanian di Agrolyn Video Edukasi",
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.videos.length,
                        itemBuilder: (context, index) {
                          final video = value.videos[index];

                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 8), // Atur jarak antar video
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      // Tombol lainnya
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
                                            borderRadius: BorderRadius.circular(
                                                8), // Sudut melengkung
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
                                            "Lihat",
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
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
