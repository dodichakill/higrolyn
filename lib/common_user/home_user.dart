import 'package:agrolyn/providers/home_user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeUser extends StatelessWidget {
  const HomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeUserNotifier(context: context),
      child: Consumer<HomeUserNotifier>(
        builder: (context, value, child) => Scaffold(),
      ),
    );
  }
}
