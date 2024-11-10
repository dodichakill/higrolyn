import 'package:flutter/material.dart';

class InformationNotifier extends ChangeNotifier {
  final BuildContext context;

  InformationNotifier({required this.context});

  final keyform = GlobalKey<FormState>();
}
