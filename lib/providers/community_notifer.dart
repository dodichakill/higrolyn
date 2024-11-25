import 'package:agrolyn/api/community_service.dart';
import 'package:agrolyn/models/detail_question_model.dart';
import 'package:agrolyn/views/farmer/comunity/detail_community_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CommunityNotifer extends ChangeNotifier {
  final BuildContext context;
  final CommunityService _communityService = CommunityService();

  CommunityNotifer({required this.context}) {
    fetchAllQuestion();
  }

  List questions = [];
  var detailQuestion;
  int questionId = 0;
  bool isLike = false, isDislike = false, isLoading = false;

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

  void fetchAllQuestion() async {
    isLoading = true;
    questions = await _communityService.getQuestions();
    notifyListeners();
  }

  Future<void> fetchDetailQuestion(int id) async {
    isLoading = true;
    notifyListeners();
    print('Fetching detail for question ID: $id');
    try {
      detailQuestion = await _communityService.getDetailQuestion(id);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(detailQuestion);
      // buatkan code untuk merefresh halaman
    } catch (e) {
      print("Error fetching details: $e");
      detailQuestion = null; // Fallback jika terjadi kesalahan
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createAnswer(
      {context,
      required int questionId,
      required int type,
      required String answer}) async {
    try {
      await _communityService
          .fetchNewAnswer(questionId: questionId, type: type, answer: answer)
          .whenComplete(() {
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCommunityScreen(id: questionId)));
      });

      notifyListeners();
      showCustomSnackbar(context, "Berhasil",
          "Selamat Jawaban Anda Berhasil Ditambahkan", ContentType.success);
    } catch (e) {
      print(e);
      showCustomSnackbar(context, "Gagal Menambahkan Jawaban",
          "Jawaban Anda Gagal Ditambahkan", ContentType.failure);
    }
  }
}
