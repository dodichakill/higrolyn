import 'package:agrolyn/shared/constants.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String name;
  final String? defaultValue;
  final bool? isDisabled;
  final TextEditingController controller;
  const TextInput(
      {super.key,
      required this.name,
      this.defaultValue,
      this.isDisabled = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isDisabled == false ? true : false,
      initialValue: defaultValue,
      controller: controller,
      decoration: InputDecoration(
        labelText: name,
        focusColor: MyColors.primaryColorDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      validator: (e) {
        if (e!.isEmpty) {
          return "$name Tidak Boleh Kosong";
        }
        return null; // Mengembalikan null jika valid
      },
    );
  }
}
