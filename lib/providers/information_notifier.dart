// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class InformationNotifier extends ChangeNotifier {
//   BuildContext context;

//   String? name;
//   String? address;
//   String? phoneNumber;
//   String? email;
//   String? imgProfile;

//   InformationNotifier() {
//     loadUserData();
//   }

//   Future<void> loadUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     name = prefs.getString('name');
//     address = prefs.getString('address');
//     phoneNumber = prefs.getString('phone_number');
//     email = prefs.getString('email');
//     imgProfile = prefs.getString('img_profile');
//     notifyListeners();
//   }
// }
