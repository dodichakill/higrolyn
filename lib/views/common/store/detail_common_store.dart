import 'package:agrolyn/providers/common_store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailCommonStore extends StatelessWidget {
  final Map<String, dynamic> product;
  const DetailCommonStore({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommonStoreNotifier(context: context),
      child: Consumer<CommonStoreNotifier>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(product['product_name']),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
