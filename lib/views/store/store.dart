import 'package:agrolyn/providers/store_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text("store"),
          ),
        ),
      ),
    );
  }
}
