import 'package:agrolyn/views/common/home/common_home.dart';
import 'package:agrolyn/views/common/order/common_order.dart';
import 'package:agrolyn/views/common/recipe/common_recipe.dart';
import 'package:agrolyn/views/common/store/common_store.dart';
import 'package:agrolyn/views/farmer/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CommonMenu extends StatelessWidget {
  final PersistentTabController? page;

  late final PersistentTabController _controller;

  CommonMenu({super.key, this.page})
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
            screen: const CommonHome(),
            item: ItemConfig(
              activeForegroundColor: Colors.green,
              icon: const Icon(Icons.home),
              title: "Beranda",
            ),
          ),
          PersistentTabConfig(
            screen: const CommonOrder(),
            item: ItemConfig(
              activeForegroundColor: Colors.green,
              icon: const Icon(Icons.description),
              title: "Pesanan",
            ),
          ),
          PersistentTabConfig(
            screen: const CommonStore(),
            item: ItemConfig(
              icon: const Icon(Icons.shopping_bag_rounded, color: Colors.white),
              activeForegroundColor: Colors.green,
              activeColorSecondary: Colors.white,
              title: "Toko",
            ),
          ),
          PersistentTabConfig(
            screen: const CommonRecipe(),
            item: ItemConfig(
              activeForegroundColor: Colors.green,
              icon: const Icon(Icons.restaurant),
              title: "resep",
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
