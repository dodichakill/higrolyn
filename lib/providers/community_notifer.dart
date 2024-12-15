import 'package:agrolyn/api/community_service.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/views/farmer/comunity/community_screen.dart';
import 'package:agrolyn/views/farmer/comunity/detail_community_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/utils/inter_prefs.dart';
import 'package:agrolyn/views/farmer/comunity/item_filter.dart';

class CommunityNotifer extends ChangeNotifier {
  final BuildContext context;
  final CommunityService _communityService = CommunityService();
  final formKey = GlobalKey<FormState>();

  CommunityNotifer({required this.context}) {
    fetchAllQuestion();
  }

  // ==================================
  // Question
  // ==================================

  String _titleQuestion = '';
  String _descriptionQuestion = '';
  File? _imageQuestion;
  String? _imageQuestionDefault;

  // Getters
  String get titleQuestion => _titleQuestion;
  String get descriptionQuestion => _descriptionQuestion;
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

  void setImageQuestion() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageQuestion = File(pickedFile.path);
      _imageQuestionDefault = '';
    }
    notifyListeners();
  }

  void setImageQuestionDefault(String value) {
    _imageQuestionDefault = value;
    notifyListeners();
  }

  void selectCategoryItemQuestion(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value == "Jagung") {
      prefs.setInt('category_id', 1);
    } else if (value == "Padi") {
      prefs.setInt('category_id', 2);
    } else {
      prefs.setInt('category_id', 3);
    }
    notifyListeners();
  }

  Future<void> submitAddQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (formKey.currentState!.validate() && imageQuestion != null) {
      final formData = FormData.fromMap({
        'title_q': titleQuestion,
        'description': descriptionQuestion,
        'plant_types_id': prefs.getInt("category_id"),
        'img_q': await MultipartFile.fromFile(imageQuestion!.path,
            filename: 'img-question.jpg'),
      });

      print(formData.fields);

      await CommunityService().fetchAddQuestion(formData).whenComplete(() {
        pushWithoutNavBar(context,
            MaterialPageRoute(builder: (context) => const CommunityScreen()));
        showCustomSnackbar(context, "Berhasil Ditambahkan",
            "Pertanyaan Anda Berhasil Ditambahkan!", ContentType.success);
      });
    }
  }

  Future<void> submitEditQuestion(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (formKey.currentState!.validate()) {
      final formData = FormData.fromMap({
        'title_q': titleQuestion,
        'description': descriptionQuestion,
        'plant_types_id': prefs.getInt("category_id"),
        if (imageQuestion != null)
          'img_q': await MultipartFile.fromFile(imageQuestion!.path,
              filename: 'img-question.jpg'),
      });

      print(formData.fields);

      await CommunityService().fetchEditQuestion(id, formData).whenComplete(() {
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCommunityScreen(
                      id: id,
                    )));
        showCustomSnackbar(context, "Berhasil Diperbarui",
            "Pertanyaan Anda Berhasil Diperbarui!", ContentType.success);
      });
    }
  }

  // Reset Form
  void resetFormQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('category_id', 0);
    _titleQuestion = '';
    _descriptionQuestion = '';
    _imageQuestion = null;
    _imageQuestionDefault = "";
    notifyListeners();
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

  // ==================================
  // Answer
  // ==================================

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
  // Search & Filter Question
  // ==================================

  String selectedOption = 'semua';
  Future<List> searchingQuestion(String value) async {
    var result = await _communityService.fetchSearchQuestion(value);
    print(result);
    questions = result;
    notifyListeners();
    return result;
  }

  void showFilterQuestion() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(ImageAssets.imgFilter),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Filter Diskusi Berdasarkan",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Kategori Tanaman",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          ItemFilter(
                              name: "Semua",
                              onTap: () async {
                                await InterPrefs.init();
                                InterPrefs.setPrefs("filterBy", "semua");
                                print("filter berdasarkan : semua");
                                notifyListeners();
                              }),
                          ItemFilter(
                              name: "Jagung",
                              onTap: () async {
                                await InterPrefs.init();
                                InterPrefs.setPrefs("filterBy", "jagung");
                                print("filter berdasarkan : jagung");
                                notifyListeners();
                              }),
                          ItemFilter(
                              name: "Padi",
                              onTap: () async {
                                await InterPrefs.init();
                                InterPrefs.setPrefs("filterBy", "padi");
                                print("filter berdasarkan : padi");
                                notifyListeners();
                              }),
                        ],
                      ),
                      const Text("Lainnya",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          ItemFilter(
                              name: "Umum",
                              onTap: () async {
                                await InterPrefs.init();
                                InterPrefs.setPrefs("filterBy", "umum");
                                print("filter berdasarkan : umum");
                              }),
                          ItemFilter(
                              name: "Pertanyaanku",
                              onTap: () async {
                                await InterPrefs.init();
                                InterPrefs.setPrefs("filterBy", "pertanyaanku");
                                print("filter berdasarkan : answerme");
                              }),
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
                                    WidgetStateProperty.all(Colors.red),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                              ),
                              child: const Text("Batalkan")),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await InterPrefs.init();
                                String value = InterPrefs.getPrefs("filterBy");
                                if (value == 'pertanyaanku') {
                                  fetchFilterQuestion('answerme');
                                } else if (value == 'semua') {
                                  fetchFilterQuestion('all');
                                }
                                fetchFilterQuestion(value);
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    MyColors.primaryColorDark),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                              ),
                              child: const Text("Terapkan"))
                        ],
                      ),
                    ])),
          ));
        });
  }

  Future<void> fetchFilterQuestion(String value) async {
    if (value == "semua") {
      fetchAllQuestion();
    } else {
      var result = await _communityService.fetchFilterQuestion(value);
      questions = result;
    }
    notifyListeners();
  }
}
