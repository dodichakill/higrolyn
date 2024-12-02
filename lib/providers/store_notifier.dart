import 'dart:io';

import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Enum untuk kategori produk
enum ProductCategory { Mentah, Olahan, Lainnya }

class StoreNotifier extends ChangeNotifier {
  final BuildContext context;

  StoreNotifier({required this.context}) {
    fetchProduct();
  }

  // Key untuk form
  final keyfrom = GlobalKey<FormState>();

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Text controllers untuk input form
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController stockEditingController = TextEditingController();
  final TextEditingController categoryEditingController =
      TextEditingController();
  final TextEditingController imgEditingController = TextEditingController();

  // Error message state
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setErrorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  // Service untuk store
  final StoreService _storeService = StoreService();
  List products = [];

  // Ambil produk
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

  // Membersihkan controller ketika widget dihancurkan
  @override
  void dispose() {
    nameEditingController.dispose();
    descEditingController.dispose();
    priceEditingController.dispose();
    stockEditingController.dispose();
    categoryEditingController.dispose();
    imgEditingController.dispose();
    super.dispose();
  }

  // Fungsi untuk membuat produk baru
  Future<void> CreateProduct({
    required String product_name,
    required String desc_product,
    required int price,
    required int stock,
    required String product_categories_id, // Misal: mentah, olahan, lainnya
    required String? img_product,
  }) async {
    try {
      String? errorMessage = await _storeService.fetchNewProduct(
        product_name: product_name,
        desc_product: desc_product,
        price: price,
        stock: stock,
        product_categories_id: product_categories_id,
        img_product: img_product,
      );

      if (errorMessage == null) {
        showCustomSnackbar(context, "Berhasil", "Produk berhasil ditambahkan",
            ContentType.success);
      } else {
        showCustomSnackbar(context, "Gagal Menambahkan Produk", errorMessage,
            ContentType.failure);
      }
    } catch (e) {
      print("Error: $e");
      showCustomSnackbar(context, "Gagal Menambahkan Produk",
          "Terjadi kesalahan saat menambahkan produk", ContentType.failure);
    }
  }

  // ==================================
  // Add Question
  // ==================================

  String _nameProduct = '';
  String _descProduct = '';
  int _priceProduct = 0;
  int _stockProduct = 0;
  int _categoryIdProduct = 1;
  File? _imageProduct;
  String? _imageProductDefault;

  // Getters
  String get nameProduct => _nameProduct;
  String get descProduct => _descProduct;
  int get priceProduct => _priceProduct;
  int get stockProduct => _stockProduct;
  int get categoryIdProduct => _categoryIdProduct;
  File? get imageProduct => _imageProduct;
  String? get imageProductDefault => _imageProductDefault;
  // Setters
  void setNameProduct(String value) {
    _nameProduct = value;
    notifyListeners();
  }

  void setDescProduct(String value) {
    _descProduct = value;
    notifyListeners();
  }

  void setPriceProduct(int value) {
    _priceProduct = value;
    notifyListeners();
  }

  void setStockProduct(int value) {
    _stockProduct = value;
    notifyListeners();
  }

  void setImageProduct(File? file) {
    _imageProduct = file;
    _imageProductDefault = '';
    notifyListeners();
  }

  void setImageProductDefault(String value) {
    _imageProductDefault = value;
    notifyListeners();
  }

  // State untuk kategori produk
  ProductCategory _category = ProductCategory.Mentah;
  ProductCategory get category => _category;

  void selectCategoryProduct(String value) {
    switch (value) {
      case "Mentah":
        _category = ProductCategory.Mentah;
        break;
      case "Olahan":
        _category = ProductCategory.Olahan;
        break;
      default:
        _category = ProductCategory.Lainnya;
    }
    notifyListeners();
  }

  // Reset Form
  void resetFormQuestion() {
    _nameProduct = '';
    _descProduct = '';
    _priceProduct = 0;
    _stockProduct = 0;
    _categoryIdProduct = 1;
    _imageProduct = null;
    _imageProductDefault = "";
    notifyListeners();
  }

  fetchNewProduct(
      {required String product_name,
      required String desc_product,
      required int price,
      required int stock,
      required String product_categories_id,
      required String img_product}) {}
}
