// import 'package:agrolyn/api/api_service.dart';
import 'package:agrolyn/providers/information_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final keyFrom = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? name;
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneNumberController.text = prefs.getString('phone_number') ?? '';
      addressController.text = prefs.getString('alamat') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const SizedBox(width: 12),
                  const Text(
                    "Informasi Akun",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              InkWell(
                onTap: () async {
                  // imageProvider.pickImage(ImageSource.gallery);
                  // ApiService().getRequest("/articles")
                },
                child: Image.asset(
                  ImageAssets.logo,
                  height: 120,
                  width: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: keyFrom,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      TextInput(
                        name: "Nama",
                        defaultValue: nameController.text,
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        name: "Email",
                        isDisabled: true,
                        defaultValue: emailController.text,
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        name: "Nomor Hp",
                        defaultValue: phoneNumberController.text,
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                          name: "Alamat", defaultValue: addressController.text),
                      const SizedBox(height: 12),
                      const Divider(
                        color: Color.fromARGB(105, 166, 243, 178),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryColorDark,
                          ),
                          child: const Text(
                            'Simpan Perubahan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text("$name"),
              Text(emailController.text),
            ],
          ),
        ),
      ),
    );
  }
}
