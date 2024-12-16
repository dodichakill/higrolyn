import 'package:flutter/material.dart';

class ProfileNotifier extends ChangeNotifier {
  final BuildContext context;

  ProfileNotifier({required this.context});

  final keyfrom = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isReviewSubmit = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setErrorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  String _reviewUser = '';
  int _ratingUser = 0;

  String get reviewUser => _reviewUser;
  int get ratingUser => _ratingUser;

  void setReviewUser(String value) {
    _reviewUser = value;
    notifyListeners();
  }

  void setRatingUser(int value) {
    _ratingUser = value;
    notifyListeners();
  }

  void resetFormReview() {
    _reviewUser = '';
    _ratingUser = 0;
    nameController.clear();
    reviewController.clear();
    ratingController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  void setReviewSubmitted() {
    isReviewSubmit = true;
    notifyListeners();
  }
}
