// ignore_for_file: use_build_context_synchronously

import 'package:agrolyn/views/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashNotifier extends ChangeNotifier {
  final BuildContext context;

  SplashNotifier({required this.context}) {
    effectSplashScreen();
  }

  effectSplashScreen() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
    });
  }
}
