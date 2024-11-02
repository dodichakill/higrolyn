import 'package:agrolyn/providers/detection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detection extends StatelessWidget {
  const Detection({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetectionNotifier(context: context),
      child: Consumer<DetectionNotifier>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text("detection"),
          ),
        ),
      ),
    );
  }
}
