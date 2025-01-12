import 'package:agrolyn/views/farmer/Profile/profile_screen.dart';
import 'package:agrolyn/views/farmer/comunity/community_screen.dart';
import 'package:agrolyn/views/farmer/detection/detection_screen.dart';
import 'package:agrolyn/views/farmer/home/home_page.dart';
import 'package:agrolyn/views/farmer/store/store.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class Menu extends StatelessWidget {
  final PersistentTabController? page;

  late final PersistentTabController _controller;

  Menu({super.key, this.page})
      : _controller = page ?? PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersistentTabView(
        controller: _controller,
        backgroundColor: Colors.white,
        tabs: [
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(
              activeForegroundColor: Colors.green,
              icon: const Icon(Icons.home),
              title: "Beranda",
            ),
          ),
          PersistentTabConfig(
            screen: Store(),
            item: ItemConfig(
              activeForegroundColor: Colors.green,
              icon: const Icon(Icons.store),
              title: "Toko",
            ),
          ),
          PersistentTabConfig(
            screen: const DetectionScreen(),
            item: ItemConfig(
              icon: const Icon(Icons.camera_alt_rounded, color: Colors.white),
              activeForegroundColor: Colors.green,
              activeColorSecondary: Colors.white,
              title: "Deteksi",
            ),
          ),
          PersistentTabConfig(
            screen: const CommunityScreen(),
            item: ItemConfig(
              activeForegroundColor: Colors.green,
              icon: const Icon(Icons.forum),
              title: "Komunitas",
            ),
          ),
          PersistentTabConfig(
            screen: const Profile(),
            item: ItemConfig(
              activeForegroundColor: Colors.green,
              icon: const Icon(Icons.person),
              title: "Profil",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style13BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(
            color:
                Colors.white, // Pilih warna navbar yang sesuai dengan tema Anda
          ),
        ),
      ),
    );
  }
}
