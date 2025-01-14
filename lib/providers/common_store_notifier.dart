import 'package:agrolyn/api/store_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonStoreNotifier extends ChangeNotifier {
  final BuildContext context;

  CommonStoreNotifier({required this.context}) {
    fetchProduct();
  }

  String role = "";

  final StoreService _storeService = StoreService();
  List products = [];

  void fetchProduct() async {
    products = await _storeService.getProducts();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('roles_id') ?? '';
    notifyListeners();
  }
}
