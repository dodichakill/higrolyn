import 'package:agrolyn/api/auth_service.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: const Text(
              'Apakah Anda yakin ingin keluar dari aplikasi agrolyn?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await AuthService().logout(context);
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
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
