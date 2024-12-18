import 'dart:io';

import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/text_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  late String? imgNetwork;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late File? imageFile;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('phone_number') ?? '';
      addressController.text = prefs.getString('address') ?? '';
      imgNetwork = prefs.getString('img_profile') ?? '';
      roleController.text =
          prefs.getString('roles_id') == "2" ? "Petani" : "Umum";
    });
  }

  Future<void> saveProfile() async {
    setState(() {
      isLoading = true;
    });

    var fromData = FormData.fromMap({
      'name': nameController.text,
      'address': addressController.text,
      'phone_number': phoneController.text,
    });

    await AuthService().editProfile(context, fromData).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Informasi Akun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imgNetwork!,
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImageAssets.logo,
                        height: 130,
                        width: 130,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            TextInput(name: "Nama", controller: nameController),
            const SizedBox(height: 16),
            TextInput(
              name: "Email",
              controller: emailController,
              isDisabled: true,
            ),
            const SizedBox(height: 16),
            TextInput(
              name: "Peran",
              controller: roleController,
              isDisabled: true,
            ),
            const SizedBox(height: 16),
            TextInput(name: "Nomor HP", controller: phoneController),
            const SizedBox(height: 16),
            TextInput(name: "Alamat", controller: addressController),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColorDark,
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : const Text(
                        'Simpan Perubahan',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
