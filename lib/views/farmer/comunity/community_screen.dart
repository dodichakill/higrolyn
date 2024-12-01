import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/comunity/card_community.dart';
import 'package:agrolyn/views/farmer/comunity/section_actions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(ImageAssets.community),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                              bottom: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: SectionActions()),
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
                                    numberOfAnswer:
                                        question['number_of_answer'],
                                    key: UniqueKey(),
                                  );
                                })
                            : Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: const Text('Belum ada topik diskusi'),
                              ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
