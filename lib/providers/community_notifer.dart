import 'package:agrolyn/api/community_service.dart';
import 'package:flutter/material.dart';

class CommunityNotifer extends ChangeNotifier {
  final BuildContext context;

  CommunityNotifer({required this.context}) {
    fetchData();
  }

  final CommunityService _communityService = CommunityService();
  List questions = [];

  void fetchData() async {
    questions = await _communityService.getQuestions();
    notifyListeners();
  }

  set selectedCategory(String selectedCategory) {}
}
