import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn/api/detection_service.dart';
import 'package:agrolyn/utils/date.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/views/farmer/detection/detail_history_scan_screen.dart';

class CardHistory extends StatelessWidget {
  final Map<String, dynamic> history;
  const CardHistory({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    void deleteHistory() {
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: const Text("Hapus Riwayat"),
      //       content: const Text(
      //           "Apakah anda yakin ingin menghapus riwayat scan tanaman ini?"),
      //       actions: [
      //         TextButton(
      //           child: const Text("Batal"),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //         TextButton(
      //           child: const Text("Ya, Hapus!"),
      //           onPressed: () async {
      //             await DetectionService()
      //                 .fetchDeleteHistory(context, history['id']);
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Hapus Riwayat',
        desc: "Apakah anda yakin ingin menghapus riwayat scan tanaman ini?",
        buttonsTextStyle: const TextStyle(color: Colors.white),
        showCloseIcon: true,
        btnCancelText: 'Batal', // Mengganti teks tombol Cancel
        btnOkText: 'Hapus', // Mengganti teks tombol OK
        btnOkColor: Colors.red, // Mengubah warna tombol OK menjadi merah
        btnCancelColor:
            Colors.grey, // Mengubah warna tombol Cancel menjadi abu-abu
        btnCancelOnPress: () {
          // Menutup dialog dengan aman
          Navigator.of(context).maybePop();
        },
        btnOkOnPress: () async {
          await DetectionService().fetchDeleteHistory(context, history['id']);
          Navigator.of(context).maybePop();
        },
      ).show();
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailHistoryScanScreen(id: history['id'])),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      // Langsung gunakan history['image_detection'] karena sudah berupa URL lengkap
                      history['image_detection'],
                      width: screenWidth,
                      height: screenWidth * 0.5,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Container(
                          width: screenWidth,
                          height: screenWidth * 0.5,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: MyColors.primaryColorDark,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: IconButton(
                        onPressed: deleteHistory,
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      history['disease_indonesian_name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "(${history['disease_name']})",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  FutureBuilder(
                    future: formatRelativeTime(history['history_date']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: const TextStyle(color: Colors.grey),
                          );
                        } else {
                          return const Text(
                            "Tanggal tidak tersedia",
                            style: TextStyle(color: Colors.grey),
                          );
                        }
                      } else {
                        return const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
