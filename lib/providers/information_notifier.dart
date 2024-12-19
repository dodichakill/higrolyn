import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationNotifier extends ChangeNotifier {
  late BuildContext context;

  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  String? imgProfile;
  File? imgProfileFile;

  InformationNotifier() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    address = prefs.getString('address');
    phoneNumber = prefs.getString('phone_number');
    email = prefs.getString('email');
    imgProfile = prefs.getString('img_profile');
    notifyListeners();
  }

  void setImageProfile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imgProfileFile = File(pickedFile.path);
      imgProfile = '';
    }
    notifyListeners();
  }
}
