import 'package:agrolyn/api/detection_service.dart';
import 'package:agrolyn/providers/detection_notifier.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/detection/card_history.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:agrolyn/widgets/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class HistoryScanScreen extends StatelessWidget {
  HistoryScanScreen({super.key});
  PersistentTabController page = PersistentTabController(initialIndex: 2);

  @override
  Widget build(BuildContext context) {
    void deleteAllHistory() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Hapus Semua Riwayat"),
              content: const Text(
                  "Apakah anda yakin ingin menghapus semua riwayat scan tanaman?"),
              actions: [
                TextButton(
                  child: const Text("Batal"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Ya, Hapus!"),
                  onPressed: () async {
                    await DetectionService().fetchDeleteAllHistory(context);
                  },
                ),
              ],
            );
          });
    }

    return ChangeNotifierProvider(
        create: (_) => DetectionNotifier(context: context, page: 'history'),
        child: Consumer<DetectionNotifier>(
            builder: (context, value, child) => Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => pushWithNavBar(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Menu(
                                            page: page,
                                          ))),
                              child: Row(children: [
                                const Icon(Icons.arrow_back),
                                const SizedBox(
                                  width: 22,
                                ),
                                const Text("Riwayat Scan Tanaman",
                                    style: TextStyle(fontSize: 20)),
                                const Spacer(),
                                IconButton(
                                    onPressed: () => deleteAllHistory(),
                                    icon: Icon(
                                      Icons.delete_sweep,
                                      color: Colors.red[300],
                                    ))
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            value.resultHistories.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: value.resultHistories.length,
                                    itemBuilder: (context, index) {
                                      return CardHistory(
                                        history: value.resultHistories[index],
                                      );
                                    })
                                : Center(
                                    child: NoFoundCustom(
                                      message: 'Hasil deteksi tidak ditemukan',
                                      subMessage:
                                          'Anda belum pernah melakukan deteksi penyakit tanaman',
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
