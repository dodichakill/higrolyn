import 'package:agrolyn/api/community_service.dart';
import 'package:agrolyn/views/farmer/comunity/detail_community_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'dart:io';

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
  String? selectedCategoryItem;

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

  Future<void> deleteAnswer(context, int answerId, int questionId) async {
    try {
      await _communityService.fetchDeleteAnwser(answerId).whenComplete(() {
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCommunityScreen(id: questionId)));
        showCustomSnackbar(context, "Berhasil Dihapus",
            "Jawaban Anda Berhasil Dihapus!", ContentType.success);
      });

      notifyListeners();
    } catch (e) {
      print(e);
      showCustomSnackbar(context, "Gagal Menghapus Jawaban",
          "Jawaban Anda Gagal Dihapus", ContentType.failure);
    }
  }

  Future<void> editAnswer(
      context, int answerId, String answer, int questionId) async {
    try {
      await _communityService
          .fetchEditAnswer(answerId, answer)
          .whenComplete(() {
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCommunityScreen(id: questionId)));
        showCustomSnackbar(context, "Berhasil Diperbarui",
            "Jawaban Anda Berhasil Diperbarui!", ContentType.success);
      });

      notifyListeners();
    } catch (e) {
      print(e);
      showCustomSnackbar(context, "Gagal Mengubah Jawaban",
          "Jawaban Anda Gagal Diubah", ContentType.failure);
    }
  }

  Future<void> likeAnswer(int answerId) async {
    await _communityService.fetchLikeAnswer(answerId);
    notifyListeners();
  }

  Future<void> dislikeAnswer(int answerId) async {
    await _communityService.fetchDislikeAnswer(answerId);
    notifyListeners();
  }

  // ==================================
  // Add Question
  // ==================================

  String _titleQuestion = '';
  String _descriptionQuestion = '';
  int _categoryIdQuestion = 1;
  File? _imageQuestion;
  String? _imageQuestionDefault;

  // Getters
  String get titleQuestion => _titleQuestion;
  String get descriptionQuestion => _descriptionQuestion;
  int get categoryIdQuestion => _categoryIdQuestion;
  File? get imageQuestion => _imageQuestion;
  String? get imageQuestionDefault => _imageQuestionDefault;
  // Setters
  void setTitleQuestion(String value) {
    _titleQuestion = value;
    notifyListeners();
  }

  void setDescriptionQuestion(String value) {
    _descriptionQuestion = value;
    notifyListeners();
  }

  void setImageQuestion(File? file) {
    _imageQuestion = file;
    _imageQuestionDefault = '';
    notifyListeners();
  }

  void setImageQuestionDefault(String value) {
    _imageQuestionDefault = value;
    notifyListeners();
  }

  void selectCategoryItemQuestion(String value) {
    print(value);
    if (value == "Jagung") {
      _categoryIdQuestion = 1;
    } else if (value == "Padi") {
      _categoryIdQuestion = 2;
    } else {
      _categoryIdQuestion = 3;
    }
    notifyListeners();
    print(_categoryIdQuestion);
  }

  // Reset Form
  void resetFormQuestion() {
    _titleQuestion = '';
    _descriptionQuestion = '';
    _categoryIdQuestion = 0;
    _imageQuestion = null;
    _imageQuestionDefault = "";
    notifyListeners();
  }

  // ==================================
  // Search Question
  // ==================================

  Future<List> searchingQuestion(String value) async {
    var result = await _communityService.fetchSearchQuestion(value);
    print(result);
    questions = result;
    notifyListeners();
    return result;
  }

  Future<List> fetchFilterQuestion(String value) async {
    var result = await _communityService.fetchFilterQuestion(value);
    print(result);
    questions = result;
    notifyListeners();
    return result;
  }
}
