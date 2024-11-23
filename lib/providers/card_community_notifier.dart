import 'package:agrolyn/api/community_service.dart';
import 'package:flutter/material.dart';

class CardCommunityNotifier extends ChangeNotifier {
  final BuildContext context;

  CardCommunityNotifier({required this.context});

  final CommunityService _communityService = CommunityService();
  bool isLike = false, isDislike = false;

  void likeQuestion(int id) async {
    await _communityService.fetchLikeQuestion(id);
    isLike = true;
    isDislike = false;
    notifyListeners();
  }

  void dislikeQuestion(int id) async {
    await _communityService.fetchDislikeQuestion(id);
    isLike = false;
    isDislike = true;
    notifyListeners();
  }

  void fetchLikeQuestion() async {
    // questions = await _communityService.getQuestions();
    // notifyListeners();
  }
}
