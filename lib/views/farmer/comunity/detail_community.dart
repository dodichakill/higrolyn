import 'package:agrolyn/api/community_service.dart';
import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailCommunity extends StatelessWidget {
  final int id;
  const DetailCommunity({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) {
          if (value.detailQuestion == null) {
            value.fetchDetailQuestion(id);
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final dataQuestion = value.detailQuestion["question_detail"],
                dataAnswer = value.detailQuestion["list_answer"],
                likeNum = dataQuestion["like_num"];

            return Scaffold(
                body: Stack(
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      Container(
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
                          children: [
                            // Bagian gambar
                            Stack(children: [
                              Image.network(
                                dataQuestion["question_thumbnail"],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 256,
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Informasi pengguna
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            dataQuestion["user_profile"]),
                                        radius: 10,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        dataQuestion["username"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.calendar_month_outlined,
                                          size: 11, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      FutureBuilder(
                                        future: formatRelativeTime(
                                            dataQuestion["released_date"]),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data.toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            );
                                          } else {
                                            return const CircularProgressIndicator(); // or some other loading indicator
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Pertanyaan
                                  Text(
                                    dataQuestion["title_question"],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    dataQuestion["description"],
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black87),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 16),

                                  // Bagian tombol interaksi
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              value.likeQuestion(id);
                                            },
                                            child: Row(
                                              children: [
                                                value.isLike
                                                    ? const Icon(
                                                        Icons
                                                            .thumb_up_alt_outlined,
                                                        size: 16,
                                                        color: Colors.green,
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .thumb_up_alt_outlined,
                                                        size: 16,
                                                        color: Colors.grey,
                                                      ),
                                                const SizedBox(width: 4),
                                                Text(
                                                    value.isLike
                                                        ? (likeNum + 1)
                                                            .toString()
                                                        : likeNum.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          InkWell(
                                            onTap: () {
                                              value.dislikeQuestion(id);
                                            },
                                            child: value.isDislike
                                                ? const Icon(
                                                    Icons
                                                        .thumb_down_alt_outlined,
                                                    size: 16,
                                                    color: Colors.red,
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .thumb_down_alt_outlined,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.beenhere_outlined,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            dataQuestion["question_type"],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.comment_outlined,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${dataQuestion["number_of_answer"]} Jawaban",
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Divider(
                                    color: MyColors.primaryColorDark,
                                  ),

                                  const Text(
                                    "Jawaban",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage: AssetImage(
                                            'assets/avatar.jpg'), // Ganti dengan path gambar Anda
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        // Expanded digunakan di sini agar teks mengambil lebar yang tersedia
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "John Doe",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "libero eget convallis fringilla, lectus magna pulvinar massa, eget euismod purus ligula a neque. Aliquam erat volutpat. Aenean justo purus",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                    Icons.thumb_up_alt_outlined,
                                                    size: 16),
                                                SizedBox(width: 4),
                                                Text("Dukung Naik - 150"),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Icon(
                                                    Icons
                                                        .thumb_down_alt_outlined,
                                                    size: 16),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage: AssetImage(
                                            'assets/avatar.jpg'), // Ganti dengan path gambar Anda
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        // Expanded digunakan di sini agar teks mengambil lebar yang tersedia
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "John Doe",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "libero eget convallis fringilla, lectus magna pulvinar massa, eget euismod purus ligula a neque. Aliquam erat volutpat. Aenean justo purus",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                    Icons.thumb_up_alt_outlined,
                                                    size: 16),
                                                SizedBox(width: 4),
                                                Text("Dukung Naik - 150"),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Icon(
                                                    Icons
                                                        .thumb_down_alt_outlined,
                                                    size: 16),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage: AssetImage(
                                            'assets/avatar.jpg'), // Ganti dengan path gambar Anda
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        // Expanded digunakan di sini agar teks mengambil lebar yang tersedia
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "John Doe",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "libero eget convallis fringilla, lectus magna pulvinar massa, eget euismod purus ligula a neque. Aliquam erat volutpat. Aenean justo purus",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                    Icons.thumb_up_alt_outlined,
                                                    size: 16),
                                                SizedBox(width: 4),
                                                Text("Dukung Naik - 150"),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Icon(
                                                    Icons
                                                        .thumb_down_alt_outlined,
                                                    size: 16),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                              width: 44,
                              height: 44,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: const Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Kembali Ke Halaman Utama Komunitas",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
          }
        },
      ),
    );
  }
}
