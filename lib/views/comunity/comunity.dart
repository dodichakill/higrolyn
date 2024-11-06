import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/searchCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(ImageAssets.community),
                  const SizedBox(
                    height: 16,
                  ),
                  const SearchCategoryWidget()
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
