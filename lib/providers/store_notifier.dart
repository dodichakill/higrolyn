import 'dart:io';

import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/views/farmer/store/store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

/// Enum untuk kategori produk
enum ProductCategory { Mentah, Olahan, Lainnya }

class StoreNotifier extends ChangeNotifier {
  final BuildContext context;

  StoreNotifier({required this.context}) {
    fetchProduct();
    searchProduct('');
  }

  final keyfrom = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isDeleting = false;
  bool get isLoading => _isLoading;
  bool get isDeleting => _isDeleting;
  List product = [];

  void setDeleting(bool value) {
    _isDeleting = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController stockEditingController = TextEditingController();
  final TextEditingController categoryProductController =
      TextEditingController();

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

  @override
  void dispose() {
    nameEditingController.dispose();
    descEditingController.dispose();
    priceEditingController.dispose();
    stockEditingController.dispose();
    categoryProductController.dispose();
    super.dispose();
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (await file.exists()) {
          _imageProduct = file;
          notifyListeners();
        } else {
          setErrorMessage("File tidak ditemukan atau tidak dapat diakses");
        }
      } else {
        setErrorMessage("Tidak ada file yang dipilih");
      }
    } catch (e) {
      setErrorMessage("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  String _nameProduct = '';
  String _descProduct = '';
  int _priceProduct = 0;
  int _stockProduct = 0;
  int _categoryIdProduct = 1;
  File? _imageProduct;
  String? _imageProductDefault;

  String get nameProduct => _nameProduct;
  String get descProduct => _descProduct;
  int get priceProduct => _priceProduct;
  int get stockProduct => _stockProduct;
  int get categoryIdProduct => _categoryIdProduct;
  File? get imageProduct => _imageProduct;
  String? get imageProductDefault => _imageProductDefault;

  int? _productId;
  int get productId => _productId ?? 0;

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

  void selectCategoryProduct(String value) {
    if (value == "Mentah") {
      _categoryIdProduct = 1;
    } else if (value == "Olahan") {
      _categoryIdProduct = 2;
    } else {
      _categoryIdProduct = 3;
    }
    categoryProductController.text = value;
    notifyListeners();
  }

  void resetFormProduct() {
    _nameProduct = '';
    _descProduct = '';
    _priceProduct = 0;
    _stockProduct = 0;
    _categoryIdProduct = 1;
    _imageProduct = null;
    _imageProductDefault = "";
    categoryProductController.clear();
    keyfrom.currentState?.reset();
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    setDeleting(true);
    try {
      await _storeService.deleteProduct(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk berhasil dihapus")),
      );
      fetchProduct();
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Produk gagal dihapus")),
      );
    } finally {
      setDeleting(false);
    }
  }

  Future<List> searchProduct(String value) async {
    var result = await _storeService.fetchSearchProduct(value);
    print(result);
    product = result;
    notifyListeners();
    return result;
  }

  Future<void> editProduct(
      BuildContext context,
      int id,
      String nameProduct,
      String descProduct,
      int price,
      int stock,
      String categoryIdProduct,
      File imageProduct) async {
    try {
      final formData = FormData.fromMap({
        "product_name": nameProduct,
        "desc_product": descProduct,
        "price": price,
        "stock": stock,
        "product_categories_id": categoryIdProduct,
        "img_product": await MultipartFile.fromFile(imageProduct.path),
      });

      print("ID Produk: $id");
      print("Form Data: $formData");

      final result = await StoreService().updateProduct(
          context,
          id,
          nameProduct,
          descProduct,
          price,
          stock,
          categoryIdProduct,
          imageProduct);
      if (result == "Produk berhasil diubah") {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Produk berhasil diubah")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Produk gagal diubah: $result")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }
}
