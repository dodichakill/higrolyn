import 'package:agrolyn/api/store_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoreNotifier extends ChangeNotifier {
  final BuildContext context;

  StoreNotifier({required this.context}) {
    fetchProduct();
  }

  final keyfrom = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController stockEditingController = TextEditingController();
  final TextEditingController categoryEditingController =
      TextEditingController();
  final TextEditingController imgEditingController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setErrorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  final StoreService _storeService = StoreService();
  List products = [];

  void fetchProduct() async {
    products = await _storeService.getProductsMe();
    notifyListeners();
  }

  // Fungsi untuk memilih gambar dari galeri atau kamera
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      imgEditingController.text =
          pickedFile.path; // Menyimpan path gambar ke controller
      notifyListeners();
    }
  }
}
