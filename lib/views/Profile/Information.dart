import 'package:agrolyn/shared/constants.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [MyColors.primaryColor, MyColors.secondaryColor]),
        ),
        child: const Center(
          child: Text("Information"),
        ),
      ),
    );
  }
}
