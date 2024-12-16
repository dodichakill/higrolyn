import 'package:agrolyn/providers/profile_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/Profile/about_screen.dart';
import 'package:agrolyn/views/farmer/Profile/information_screen.dart';
import 'package:agrolyn/views/farmer/Profile/review_screnn.dart';
import 'package:agrolyn/widgets/deeplink.dart';
import 'package:agrolyn/widgets/item_menu_profile.dart';
import 'package:agrolyn/widgets/logout.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileNotifier(context: context),
      child: Consumer<ProfileNotifier>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Headline Profile
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
                                FutureBuilder(
                                    future: SharedPreferences.getInstance(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        SharedPreferences prefs =
                                            snapshot.data as SharedPreferences;
                                        String name =
                                            prefs.getString('name') ?? '';
                                        String email =
                                            prefs.getString('email') ?? '';
                                        String address =
                                            prefs.getString('address') ?? '';
                                        String imgProfile =
                                            prefs.getString('img_profile') ??
                                                '';
                                        String roleId =
                                            prefs.getString('roles_id') ?? '';
                                        return Row(children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                  imgProfile,
                                                  height: 70,
                                                  width: 70,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      ImageAssets.logo,
                                                      height: 70,
                                                      width: 70,
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    email,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        address,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.green[700],
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  roleId == "2"
                                                      ? "Petani"
                                                      : "Umum",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]);
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    })
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 16,
                      ),

                      // List Menu
                      const ItemMenuProfile(
                        icon: Icons.person,
                        name: "Informasi Akun",
                        page: InformationScreen(),
                      ),
                      // const ItemMenuProfile(
                      //   icon: Icons.notes,
                      //   name: "Syarat dan Ketentuan",
                      // ),
                      ItemMenuProfile(
                        icon: Icons.star,
                        name: "Beri ulasan dan Rating",
                        onTap: value.isReviewSubmit
                            ? null // Nonaktifkan tombol jika ulasan sudah diberikan
                            : () {
                                pushWithoutNavBar(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewScreen(),
                                  ),
                                );
                              },
                      ),
                      const ItemMenuProfile(
                        icon: Icons.info_outline,
                        name: "Tentang Aplikasi",
                        page: AboutScreen(),
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
