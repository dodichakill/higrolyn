import 'package:flutter/material.dart';
import 'package:agrolyn/utils/date.dart';

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
                  onTap: () {
                    likeQuestion(dataQuestion["id"]);
                  },
                  child: Row(
                    children: [
                      isLike
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
            const Row(
              children: [
                Icon(
                  Icons.edit_note_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                SizedBox(width: 4),
                Text(
                  "Edit Pertanyaan",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
