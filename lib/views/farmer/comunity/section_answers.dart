import 'package:flutter/material.dart';
import 'package:agrolyn/views/farmer/comunity/card_answer.dart';

class SectionAnswers extends StatelessWidget {
  final Map<String, dynamic> dataQuestion;
  final List<dynamic> dataAnswer;
  const SectionAnswers(
      {super.key, required this.dataQuestion, required this.dataAnswer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(children: [
            const Icon(
              Icons.comment_outlined,
              size: 16,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              dataQuestion["number_of_answer"].toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              "Jawaban",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
          ]),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataAnswer.length,
              itemBuilder: (context, index) {
                return CardAnswer(
                  id: dataAnswer[index]["id"],
                  answer: dataAnswer[index]["answer"],
                  username: dataAnswer[index]["username"],
                  releasedDate: dataAnswer[index]["released_date"],
                  userProfile: dataAnswer[index]["user_profile"],
                  likeNum: dataAnswer[index]["like_num"],
                  questionId: dataQuestion["id"],
                );
              }),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
