import 'package:agrolyn/providers/menu_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/views/Profile/profile.dart';
import 'package:agrolyn/views/comunity/comunity.dart';
import 'package:agrolyn/views/detection/detection.dart';
import 'package:agrolyn/views/home/home_page.dart';
import 'package:agrolyn/views/store/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuNotifier(context: context),
      child: Consumer<MenuNotifier>(
        builder: (context, value, child) => Scaffold(
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: value.page == 0
                          ? const HomePage()
                          : value.page == 1
                              ? const Store()
                              : value.page == 2
                                  ? const Detection()
                                  : value.page == 3
                                      ? const Community()
                                      : const Profile(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 72,
                    color: Colors.white.withOpacity(0.6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              value.changePage(0);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home,
                                  size: 26,
                                  color: value.page == 0
                                      ? const Color.fromARGB(255, 22, 22, 22)
                                      : Colors.grey,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    color: value.page == 0
                                        ? const Color.fromARGB(255, 22, 22, 22)
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              value.changePage(1);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.store,
                                  size: 26,
                                  color: value.page == 1
                                      ? const Color.fromARGB(255, 22, 22, 22)
                                      : Colors.grey,
                                ),
                                Text(
                                  "Toko",
                                  style: TextStyle(
                                    color: value.page == 1
                                        ? const Color.fromARGB(255, 22, 22, 22)
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: OverflowBox(
                              maxHeight:
                                  120, // Tinggi yang lebih besar untuk menonjol lebih jauh
                              child: GestureDetector(
                                onTap: () => value.changePage(2),
                                child: Container(
                                  width: 60,
                                  height:
                                      90, // Atur tinggi untuk menonjol lebih jauh
                                  margin: const EdgeInsets.only(
                                      bottom: 20), // Menaikkan posisi
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_rounded,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Deteksi",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => value.changePage(3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.forum,
                                  size: 26,
                                  color: value.page == 3
                                      ? const Color.fromARGB(255, 22, 22, 22)
                                      : Colors.grey,
                                ),
                                Text(
                                  "Komunitas",
                                  style: TextStyle(
                                    color: value.page == 3
                                        ? const Color.fromARGB(255, 22, 22, 22)
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => value.changePage(4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 26,
                                  color: value.page == 4
                                      ? const Color.fromARGB(255, 22, 22, 22)
                                      : Colors.grey,
                                ),
                                Text(
                                  "Profil",
                                  style: TextStyle(
                                    color: value.page == 4
                                        ? const Color.fromARGB(255, 22, 22, 22)
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
