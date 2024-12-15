import 'dart:async';

import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/inter_prefs.dart';
import 'package:flutter/material.dart';

class ItemFilter extends StatefulWidget {
  String name;
  Function() onTap;
  ItemFilter({super.key, required this.name, required this.onTap});

  @override
  State<ItemFilter> createState() => _ItemFilterState();
}

class _ItemFilterState extends State<ItemFilter> {
  String filterBy = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      loadData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> loadData() async {
    await InterPrefs.init();
    String filter = InterPrefs.getPrefs('filterBy');
    setState(() {
      filterBy = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: widget.name.toLowerCase() == filterBy
                  ? MyColors.primaryColor
                  : Colors.white,
              border: Border.all(color: MyColors.primaryColorDark),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          padding: const EdgeInsets.all(8),
          child: Text(widget.name),
        ));
  }
}
