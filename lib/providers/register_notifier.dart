import 'package:flutter/material.dart';

class RegisterNotifier extends ChangeNotifier {
  final BuildContext context;

  RegisterNotifier({required this.context});

  final keyfrom = GlobalKey<FormState>();
}
