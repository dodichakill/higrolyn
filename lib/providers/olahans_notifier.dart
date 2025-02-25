import 'package:agrolyn/api/olahan_service.dart';
import 'package:flutter/material.dart';

class OlahansNotifier extends ChangeNotifier {
  final BuildContext context;
  final OlahanService _olahanService = OlahanService();
  final int idCat;

  bool isLoading = false;
  List olahans = [];
  List detailOlahans = [];

  OlahansNotifier(this.idCat, {required this.context}) {
    fetchAllOlahans();
    fetchAllDetailRecomendation();
  }

  void fetchAllOlahans() async {
    isLoading = true;
    notifyListeners();
    try {
      olahans = await _olahanService.getOlahans();
    } catch (e) {
      print("Error fetching olahans: $e");
      olahans = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void fetchAllDetailRecomendation() async {
    isLoading = true;
    notifyListeners();
    try {
      detailOlahans = await _olahanService.getRecommendationId(context, idCat);
      print(
          "Detail Olahan Fetched: $detailOlahans"); // Log untuk memastikan data diterima
    } catch (e) {
      print("Error fetching olahans: $e");
      detailOlahans = [];
    } finally {
      isLoading = false;
      notifyListeners(); // Pastikan UI diupdate setelah data dimuat
    }
  }
}
