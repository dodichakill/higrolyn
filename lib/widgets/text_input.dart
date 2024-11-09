import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String name;
  const TextInput({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: name,
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
