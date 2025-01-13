import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/utils/inter_prefs.dart';
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
                                Expanded(
                                  child: InkWell(
                                    onTap: () => value.showFilterQuestion(),
                                    child: Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: MyColors.primaryColorDark),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.filter_alt_rounded,
                                            color: MyColors.primaryColorDark,
                                            size: 28,
                                          ),
                                          const SizedBox(width: 8),
                                          const Flexible(
                                            child: Text(
                                              "Filter Diskusi",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    MyColors.primaryColorDark,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        8), // Add some space between the buttons

                                Expanded(
                                  child: InkWell(
                                    onTap: () => addQuestion(value),
                                    child: Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: MyColors.primaryColorDark),
                                        color: MyColors.primaryColorDark,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add_circle,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                          const SizedBox(width: 8),
                                          const Flexible(
                                            child: Text(
                                              "Buat Diskusi",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
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
