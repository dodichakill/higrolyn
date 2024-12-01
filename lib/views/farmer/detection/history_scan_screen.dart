import 'package:agrolyn/views/farmer/detection/card_history.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HistoryScanScreen extends StatelessWidget {
  HistoryScanScreen({super.key});
  PersistentTabController page = PersistentTabController(initialIndex: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                InkWell(
                  onTap: () => pushWithNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Menu(
                                page: page,
                              ))),
                  child: const Row(children: [
                    Icon(Icons.arrow_back),
                    SizedBox(
                      width: 22,
                    ),
                    Text("Riwayat Scan Tanaman",
                        style: TextStyle(fontSize: 20)),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CardHistory(),
                const CardHistory(),
                const CardHistory(),
                const CardHistory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
