import 'package:agrolyn/providers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileNotifier(context: context),
      child: Consumer<ProfileNotifier>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text("profile"),
          ),
        ),
      ),
    );
  }
}
