import 'package:agrolyn/providers/card_community_notifier.dart';
import 'package:agrolyn/views/farmer/comunity/detail_community.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class CardCommunity extends StatelessWidget {
  final int id, likeNum, numberOfAnswer;
  final String thumbnail, type, date, title, imgProfile, username;

  const CardCommunity({
    super.key,
    required this.id,
    required this.thumbnail,
    required this.type,
    required this.date,
    required this.title,
    required this.imgProfile,
    required this.username,
    required this.likeNum,
    required this.numberOfAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CardCommunityNotifier(context: context),
        child: Consumer<CardCommunityNotifier>(
            builder: (context, value, child) => InkWell(
                  onTap: () {
                    pushWithoutNavBar(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailCommunity()));
                  },
                  child: Container(
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
                        // Bagian gambar
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: thumbnail.isNotEmpty
                              ? Image.network(
                                  thumbnail,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150,
                                )
                              : const Text("No image available"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Informasi pengguna
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(imgProfile),
                                    radius: 10,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.tag,
                                      size: 11, color: Colors.grey),
                                  Text(
                                    type,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Pertanyaan
                              Text(
                                title,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Divider(color: Colors.grey.shade300),
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
                                                    Icons.thumb_up_alt_outlined,
                                                    size: 16,
                                                    color: Colors.green,
                                                  )
                                                : const Icon(
                                                    Icons.thumb_up_alt_outlined,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                            const SizedBox(width: 4),
                                            Text(value.isLike
                                                ? (likeNum + 1).toString()
                                                : likeNum.toString()),
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
                                                Icons.thumb_down_alt_outlined,
                                                size: 16,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.thumb_down_alt_outlined,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.comment, size: 16),
                                      const SizedBox(width: 4),
                                      Text("$numberOfAnswer Jawaban"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
