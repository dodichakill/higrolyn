import 'package:agrolyn/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ItemMenuProfile extends StatelessWidget {
  final String name;
  final IconData icon;
  final Widget? page;

  const ItemMenuProfile({
    super.key,
    required this.name,
    required this.icon,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        page != null
            ? pushWithoutNavBar(
                context,
                MaterialPageRoute(
                    builder: (context) => page != null ? page! : Container()))
            : null
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: Color.fromARGB(157, 161, 222, 192),
              width: 1,
            )),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: MyColors.primaryColorDark,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black45,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
