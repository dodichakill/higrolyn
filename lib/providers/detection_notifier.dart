import 'package:agrolyn/api/detection_service.dart';
import 'package:flutter/material.dart';

class DetectionNotifier extends ChangeNotifier {
  final BuildContext context;

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

  DetectionNotifier({required this.context});
}
