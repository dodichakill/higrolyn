import 'package:agrolyn/utils/assets_path.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(ImageAssets.onboarding1),
          Image.asset(ImageAssets.onboarding1),
          Image.asset(ImageAssets.onboarding1),
          Image.asset(ImageAssets.onboarding1),
          Image.asset(ImageAssets.onboarding1)
        ],
      ),
    );
  }
}
