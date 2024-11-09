import 'package:agrolyn/providers/profile_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/Profile/Information.dart';
import 'package:agrolyn/views/splash_screen.dart';
import 'package:agrolyn/widgets/ItemMenuProfile.dart';
import 'package:agrolyn/widgets/Logout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileNotifier(context: context),
      child: Consumer<ProfileNotifier>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Headline Profile Start
                      Container(
                          color: MyColors.primaryColorDark,
                          width: double.infinity,
                          height: 168,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 16, left: 16, right: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      ImageAssets.logo,
                                      width: 70,
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Faisal Putriani",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "johndoe123@gmail.com",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "Tegal, Jawa Tengah",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.green[700],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Petani",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 16,
                      ),

                      // Menu
                      const ItemMenuProfile(
                        icon: Icons.person,
                        name: "Informasi Akun",
                        page: InformationScreen(),
                      ),
                      const ItemMenuProfile(
                        icon: Icons.notes,
                        name: "Syarat dan Ketentuan",
                      ),
                      const ItemMenuProfile(
                        icon: Icons.star,
                        name: "Beri ulasan dan Rating",
                      ),
                      const ItemMenuProfile(
                        icon: Icons.info_outline,
                        name: "Tentang Aplikasi",
                      ),
                      const Logout(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
