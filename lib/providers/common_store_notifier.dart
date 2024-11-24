import 'package:agrolyn/api/store_service.dart';
import 'package:flutter/material.dart';

class CommonStoreNotifier extends ChangeNotifier {
  final BuildContext context;

  CommonStoreNotifier({required this.context}) {
    fetchProduct();
  }

  final StoreService _storeService = StoreService();
  List products = [];

  void fetchProduct() async {
    products = await _storeService.getProducts();
    notifyListeners();
  }
}
