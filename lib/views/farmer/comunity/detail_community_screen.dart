import 'dart:ui';

import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/utils/inter_prefs.dart';
import 'package:agrolyn/views/farmer/comunity/content_question_detail.dart';
import 'package:agrolyn/views/farmer/comunity/input_answer.dart';
import 'package:agrolyn/views/farmer/comunity/section_answers.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class DetailCommunityScreen extends StatefulWidget {
  final int id;
  final String? name;

  const DetailCommunityScreen({super.key, required this.id, this.name});

  @override
  State<DetailCommunityScreen> createState() => _DetailCommunityScreenState();
}

class _DetailCommunityScreenState extends State<DetailCommunityScreen> {
  String? userName;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = widget.name ?? prefs.getString('name');
        isInitialized = true;
      });
    } catch (e) {
      setState(() {
        userName = widget.name;
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) {
          // Only fetch once when detailQuestion is null
          if (value.detailQuestion == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                value.fetchDetailQuestion(widget.id);
              }
            });
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final dataQuestion = value.detailQuestion["question_detail"];
          final dataAnswer = value.detailQuestion["list_answer"];
          final likeNum = dataQuestion["like_num"];

          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Stack(fit: StackFit.expand, children: [
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
                                            likeQuestion: value.likeQuestion,
                                            dislikeQuestion:
                                                value.dislikeQuestion,
                                            likeNum: likeNum,
                                            nameUser: userName),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Tombol "Kembali Ke Halaman Utama Komunitas"
                            Positioned(
                                top: 20,
                                left: 16,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await InterPrefs.init();
                                          InterPrefs.setPrefs(
                                              "filterBy", "semua");
                                          value.reNotifyListeners();
                                          PersistentTabController page =
                                              PersistentTabController(
                                                  initialIndex: 3);
                                          pushWithoutNavBar(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Menu(page: page)));
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          size: 24,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        // bagian jawaban
                        SectionAnswers(
                          dataQuestion: dataQuestion,
                          dataAnswer: dataAnswer,
                          name: userName,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  InputAnswer(
                    questionId: widget.id,
                    type: dataQuestion["question_type"] == "jagung"
                        ? 1
                        : dataQuestion["question_type"] == "padi"
                            ? 2
                            : dataQuestion["question_type"] == "tomat"
                                ? 3
                                : 4,
                  )
                ]),
              ));
        },
      ),
    );
  }
}
