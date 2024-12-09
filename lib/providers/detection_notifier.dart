import 'package:agrolyn/api/detection_service.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class DetectionNotifier extends ChangeNotifier {
  final BuildContext context;
  DetectionNotifier({required this.context, String? page}) {
    if (page == "history") {
      fetchHistory();
    }
  }

  bool historyIsLoading = false;
  bool predictionIsLoading = false;

  var resultHistories = [];

  Future<List> fetchHistory() async {
    var result = await DetectionService().fetchGetHistory();
    print(result);
    resultHistories = result;
    notifyListeners();
    return result;
  }

  // Future<String> deleteHistory(int id) async {
  //   var result =
  //       await DetectionService().fetchDeleteHistory(id).whenComplete(() {
  //     showCustomSnackbar(context, "Berhasil Dihapus",
  //         "Riwayat Berhasil Dihapus!", ContentType.success);
  //   });
  //   print(result);
  //   return result;
  // }
}
