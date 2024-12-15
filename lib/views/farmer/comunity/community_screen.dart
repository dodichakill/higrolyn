import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/comunity/card_community.dart';
import 'package:agrolyn/views/farmer/comunity/add_question.dart';
import 'package:agrolyn/views/farmer/comunity/item_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void addQuestion(value) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (_) => CommunityNotifer(context: context),
            builder: (context, child) => const AddQuestion(),
          );
        },
      );
    }

    void filterQuestion(value) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ChangeNotifierProvider(
                create: (_) => CommunityNotifer(context: context),
                builder: (context, child) => Center(
                        child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Filter Berdasarkan",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text("Kategori Tanaman",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  children: [
                                    ItemFilter(name: "Semua", onTap: () {}),
                                    ItemFilter(name: "Jagung", onTap: () {}),
                                    ItemFilter(name: "Padi", onTap: () {}),
                                  ],
                                ),
                                const Text("Lainnya",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  children: [
                                    ItemFilter(name: "Umum", onTap: () {}),
                                    ItemFilter(
                                        name: "Pertanyaanku", onTap: () {}),
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Divider(color: Colors.grey[300], thickness: 1),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white),
                                        ),
                                        child: const Text("Batalkan")),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  MyColors.primaryColorDark),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white),
                                        ),
                                        child: const Text("Terapkan"))
                                  ],
                                ),
                              ])),
                    )));
          });
    }

    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 70),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImageAssets.community),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          bottom: 8,
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 48,
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
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText:
                                      "Cari topik diskusi favoritmu disini",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 20.0,
                                  ),
                                ),
                                onChanged: (keyword) {
                                  if (keyword.length > 2) {
                                    value.searchingQuestion(keyword);
                                  } else {
                                    value.fetchAllQuestion();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => filterQuestion(value),
                                      child: Container(
                                        height: 48,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color: MyColors.primaryColorDark,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.filter_alt_rounded,
                                              color: MyColors.primaryColorDark,
                                              size: 28,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Filter Diskusi",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: MyColors
                                                      .primaryColorDark),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                // Add Question
                                InkWell(
                                  onTap: () => addQuestion(value),
                                  child: Container(
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: MyColors.primaryColorDark,
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Buat Diskusi Baru",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    value.questions.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.questions.length,
                            itemBuilder: (context, index) {
                              var question = value.questions[index];
                              return CardCommunity(
                                id: question['id'],
                                thumbnail: question['question_thumbnail'],
                                title: question['title_question'],
                                type: question['question_type'],
                                date: question['released_date'],
                                imgProfile: question['user_profile'],
                                likeNum: question['like_num'],
                                username: question['username'],
                                numberOfAnswer: question['number_of_answer'],
                                key: UniqueKey(),
                              );
                            })
                        : Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text('Belum ada topik diskusi'),
                          ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
