import 'package:agrolyn/shared/constants.dart';
import 'package:flutter/material.dart';

class ItemFilter extends StatelessWidget {
  String name;
  Function() onTap;
  ItemFilter({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(color: MyColors.primaryColorDark),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              )),
          padding: const EdgeInsets.all(8),
          child: Text(name),
        ));
  }
}
