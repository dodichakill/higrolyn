import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart'
    hide AnimatedButton;
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  void showExitDialog(BuildContext context) {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Konfirmasi Keluar'),
    //       content: const Text(
    //           'Apakah Anda yakin ingin keluar dari aplikasi agrolyn?'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop(); // Tutup dialog
    //           },
    //           child: const Text('Batal'),
    //         ),
    //         TextButton(
    //           onPressed: () async {
    //             await AuthService().logout(context);
    //           },
    //           child: const Text('Keluar'),
    //         ),
    //       ],
    //     );
    //   },
    // );
    // AnimatedButton(
    //   text: 'Info Dialog fixed width and square buttons',
    //   pressEvent: () {
    //     AwesomeDialog(
    //       context: context,
    //       dialogType: DialogType.info,
    //       borderSide: const BorderSide(
    //         color: Colors.green,
    //         width: 2,
    //       ),
    //       width: 280,
    //       buttonsBorderRadius: const BorderRadius.all(
    //         Radius.circular(2),
    //       ),
    //       dismissOnTouchOutside: true,
    //       dismissOnBackKeyPress: false,
    //       onDismissCallback: (type) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             content: Text('Dismissed by $type'),
    //           ),
    //         );
    //       },
    //       headerAnimationLoop: false,
    //       animType: AnimType.bottomSlide,
    //       title: 'Logout',
    //       desc: 'This Dialog can be dismissed touching outside',
    //       showCloseIcon: true,
    //       btnCancelOnPress: () {
    //         Navigator.of(context).pop(); // Tutup dialog
    //       },
    //       btnOkOnPress: () async {
    //         await AuthService().logout(context);
    //       },
    //     ).show();
    //   },
    // );
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Konfirmasi Keluar',
      desc: 'Apakah Anda yakin ingin keluar dari aplikasi agrolyn?',
      buttonsTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      btnCancelText: 'Tidak', // Mengganti teks tombol Cancel
      btnOkText: 'Ya', // Mengganti teks tombol OK
      btnOkColor:
          MyColors.primaryColorDark, // Mengubah warna tombol OK menjadi merah
      btnCancelColor:
          Colors.red, // Mengubah warna tombol Cancel menjadi abu-abu
      btnCancelOnPress: () {
        // Menutup dialog dengan aman
        Navigator.of(context).maybePop();
      },
      btnOkOnPress: () async {
        await AuthService().logout(context); // Proses logout
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showExitDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: Color.fromARGB(157, 222, 173, 161),
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
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Keluar",
                          style: TextStyle(
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
