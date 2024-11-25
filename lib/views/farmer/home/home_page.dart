import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/providers/home_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/chatbot/chatbot.dart';
import 'package:agrolyn/views/farmer/home/detail_article.dart';
import 'package:flutter/material.dart';
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
      child: Consumer<HomeNotifier>(
        builder: (context, value, child) => SafeArea(
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
                                    "Solusi Pertanian Cerdas Masa Depan",
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
                            padding: const EdgeInsets.only(
                                right: 8, left: 8, bottom: 8),
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
                          value.articles.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 8, left: 8),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: value.articles.length,
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
                                          child: Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      article['thumbnail'] !=
                                                                  null &&
                                                              article['thumbnail']
                                                                  .isNotEmpty
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  Image.network(
                                                                article[
                                                                    'thumbnail'],
                                                                width: 85,
                                                                height: 85,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : const Text(
                                                              "Thumbnail not available"),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${article['title']}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                                height: 2),
                                                            Text(
                                                              "${article['description']}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : const Center(
                                  child: Text("No articles available"),
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
                                      "Video Edukasi",
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.videos.length,
                            itemBuilder: (context, index) {
                              final video = value.videos[index];
                              return Container(
                                margin: const EdgeInsets.all(16),
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
                                    // Bagian gambar thumbnail video
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                      child: Image.network(
                                        video['snippet']['thumbnails']
                                            ['default']['url'],
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
                                          // Judul video, maksimal 1 baris
                                          Text(
                                            video['snippet']['title'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          // Deskripsi video, maksimal 2 baris
                                          Text(
                                            video['snippet']['description'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          // Tombol atau aksi lainnya
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.open_in_new),
                                                onPressed: () {
                                                  // Navigasi untuk membuka link video
                                                  final videoId =
                                                      video['id']['videoId'];
                                                  final url =
                                                      'https://www.youtube.com/watch?v=$videoId';
                                                  print('Opening URL: $url');
                                                },
                                              ),
                                              // Tambahkan tombol atau aksi lainnya jika diperlukan
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                child: InkWell(
                              onTap: () {},
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                              ),
                            )),
                          ],
                        ),
                      ),
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
        ),
      ),
    );
  }
}
