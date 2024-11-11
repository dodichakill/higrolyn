// import 'package:agrolyn/api/api_service.dart';
import 'package:agrolyn/providers/information_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InformationNotifier(context: context),
      child: Consumer<InformationNotifier>(
          builder: (context, value, child) => Scaffold(
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
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
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
                          key: value.keyform,
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              const TextInput(
                                name: "Nama",
                                defaultValue: "Daniel Pratama",
                              ),
                              const SizedBox(height: 12),
                              const TextInput(
                                name: "Email",
                                isDisabled: true,
                                defaultValue: "johndoe123@gmail.com",
                              ),
                              const SizedBox(height: 12),
                              const TextInput(
                                name: "Nomor Hp",
                                defaultValue: "08123456789",
                              ),
                              const SizedBox(height: 12),
                              const TextInput(
                                  name: "Alamat",
                                  defaultValue: "Kota Tegal, Jawa Tengah"),
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
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
