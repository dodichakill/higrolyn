import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      extendBody: true,
      bottomNavigationBar: FluidNavBar(icons: [
        FluidNavBarIcon(icon: Icons.home),
        FluidNavBarIcon(icon: Icons.store),
        FluidNavBarIcon(icon: Icons.camera_alt),
        FluidNavBarIcon(icon: Icons.person),
      ]),
    );
  }
}
