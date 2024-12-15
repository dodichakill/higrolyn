import 'package:agrolyn/api/community_service.dart';
import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/views/farmer/comunity/edit_question.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn/utils/date.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentQuestionDetail extends StatelessWidget {
  Map<String, dynamic> dataQuestion = {};
  bool isLike, isDislike;
  String? nameUser;
  int likeNum;
  void Function(int) likeQuestion, dislikeQuestion;
  ContentQuestionDetail(
      {super.key,
      this.nameUser,
      required this.dataQuestion,
      required this.isLike,
      required this.isDislike,
      required this.likeQuestion,
      required this.dislikeQuestion,
      required this.likeNum});

  @override
  Widget build(BuildContext context) {
    void editQuestion() async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
              create: (_) => CommunityNotifer(context: context),
              builder: (context, child) {
                return EditQuestion(
                  id: dataQuestion["id"],
                  titleQuestion: dataQuestion["title_question"],
                  imageQuestionDefault: dataQuestion["question_thumbnail"],
                  descriptionQuestion: dataQuestion["description"],
                );
              });
        },
      );
    }

    void deleteQuestion() async {
      await CommunityService().fetchDeleteQuestion(context, dataQuestion["id"]);
    }

    void showConfirmDelete() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Hapus Pertanyaan?'),
              content: const Text(
                  'Apakah Anda yakin ingin menghapus pertanyaan ini?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () async {
                    deleteQuestion();
                  },
                  child: const Text('Ya, Hapus!'),
                ),
              ],
            );
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(dataQuestion["user_profile"]),
              radius: 10,
            ),
            const SizedBox(width: 8),
            Text(
              dataQuestion["username"],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const Spacer(),
            const Icon(Icons.calendar_month_outlined,
                size: 11, color: Colors.grey),
            const SizedBox(width: 4),
            FutureBuilder(
              future: formatRelativeTime(dataQuestion["released_date"]),
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
          ],
        ),
        const SizedBox(height: 8),
        // Pertanyaan
        Text(
          dataQuestion["title_question"],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          dataQuestion["description"],
          style: const TextStyle(fontSize: 15, color: Colors.black87),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        Divider(color: Colors.grey.shade300),
        const SizedBox(
          height: 8,
        ),
        // Bagian tombol interaksi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    likeQuestion(dataQuestion["id"]);
                  },
                  child: Row(
                    children: [
                      isLike
                          ? const Icon(
                              Icons.thumb_up,
                              size: 16,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.thumb_up_alt_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                      const SizedBox(width: 8),
                      Text(
                          isLike
                              ? (likeNum + 1).toString()
                              : likeNum.toString(),
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    dislikeQuestion(dataQuestion["id"]);
                  },
                  child: isDislike
                      ? const Icon(
                          Icons.thumb_down,
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
            // type question
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
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            // actions edit/delete
            nameUser == dataQuestion["username"]
                ? Row(
                    children: [
                      Row(children: [
                        const Icon(
                          Icons.edit_note_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => editQuestion(),
                          child: const Text(
                            "Ubah",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ]),
                      const SizedBox(width: 8),
                      Row(children: [
                        Icon(
                          Icons.delete_outline,
                          size: 16,
                          color: Colors.red[400],
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => showConfirmDelete(),
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.red[400]),
                          ),
                        ),
                      ])
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
