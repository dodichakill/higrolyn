import 'package:flutter/material.dart';
import 'package:agrolyn/utils/date.dart';

class CardAnswer extends StatelessWidget {
  String answer, userProfile, username, releasedDate;
  int id, likeNum;

  CardAnswer(
      {super.key,
      required this.answer,
      required this.userProfile,
      required this.username,
      required this.releasedDate,
      required this.id,
      required this.likeNum});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  NetworkImage(userProfile), // Ganti dengan path gambar Anda
            ),
            const SizedBox(width: 8),
            Expanded(
              // Expanded digunakan di sini agar teks mengambil lebar yang tersedia
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      username,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    const Spacer(),
                    const Icon(Icons.calendar_month_outlined,
                        size: 11, color: Colors.grey),
                    const SizedBox(width: 4),
                    FutureBuilder(
                      future: formatRelativeTime(releasedDate),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.grey),
                          );
                        } else {
                          return const CircularProgressIndicator(); // or some other loading indicator
                        }
                      },
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Text(
                    answer,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // value.likeQuestion(id);
                            },
                            child: Row(
                              children: [
                                // value.isLike
                                //     ? const Icon(
                                //         Icons.thumb_up_alt_outlined,
                                //         size: 16,
                                //         color: Colors.green,
                                //       )
                                //     :
                                const Icon(
                                  Icons.thumb_up_alt_outlined,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                    // value.isLike
                                    //     ? (likeNum + 1).toString()
                                    //     :
                                    20.toString(),
                                    style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              // value.dislikeQuestion(id);
                            },
                            child:
                                // value.isDislike
                                //     ? const Icon(
                                //         Icons.thumb_down_alt_outlined,
                                //         size: 16,
                                //         color: Colors.red,
                                //       )
                                //     :
                                const Icon(
                              Icons.thumb_down_alt_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4),
                            Text("Ubah Jawaban",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Divider(color: Colors.grey.shade300),
    ]);
  }
}
