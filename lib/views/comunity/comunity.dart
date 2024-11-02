import 'package:agrolyn/providers/comunity_notifer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comunity extends StatelessWidget {
  const Comunity({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComunityNotifer(context: context),
      child: Consumer<ComunityNotifer>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text("comunity"),
          ),
        ),
      ),
    );
  }
}
