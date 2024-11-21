import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CommonMenuNotifier extends ChangeNotifier {
  final BuildContext context;

  CommonMenuNotifier({required this.context});

  PersistentTabController _page = PersistentTabController(initialIndex: 0);

  PersistentTabController get page => _page;

  set setPage(PersistentTabController value) {
    _page = value;
    notifyListeners();
  }
}
