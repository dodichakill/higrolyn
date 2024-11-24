import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/views/farmer/comunity/card_answer.dart';
import 'package:agrolyn/views/farmer/comunity/content_question_detail.dart';
import 'package:agrolyn/views/farmer/comunity/input_answer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCommunityScreen extends StatelessWidget {
  final int id;
  String? name;
  DetailCommunityScreen({super.key, required this.id, this.name}) {
    initialize();
  }

  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
  }

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
                backgroundColor: Colors.white,
                body: Stack(children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                  // main content
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Konten Detail Pertanyaan + interaksi
                                        ContentQuestionDetail(
                                            dataQuestion: dataQuestion,
                                            isLike: value.isLike,
                                            isDislike: value.isDislike,
                                            likeQuestion: value.likeQuestion,
                                            dislikeQuestion:
                                                value.dislikeQuestion,
                                            likeNum: likeNum,
                                            nameUser: name),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Tombol "Kembali Ke Halaman Utama Komunitas"
                            Positioned(
                              top: 35,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            border:
                                                Border.all(color: Colors.grey),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )),
                                    )),
                              ),
                            )
                          ],
                        ),
                        // bagian jawaban
                        Padding(
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
                                  itemCount: dataAnswer?.length,
                                  itemBuilder: (context, index) {
                                    return CardAnswer(
                                      id: dataAnswer[index]["id"],
                                      answer: dataAnswer[index]["answer"],
                                      username: dataAnswer[index]["username"],
                                      releasedDate: dataAnswer[index]
                                          ["released_date"],
                                      userProfile: dataAnswer[index]
                                          ["user_profile"],
                                      likeNum: dataAnswer[index]["like_num"],
                                    );
                                  }),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InputAnswer()
                ]));
          }
        },
      ),
    );
  }
}
