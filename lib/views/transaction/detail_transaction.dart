import 'package:agrolyn/providers/store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/transaction/virtual_account.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class DetailTransaction extends StatelessWidget {
  const DetailTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Metode Pembayaran",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Silahkan pilih metode pembayaran yang anda diinginkan",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Bank Virtual Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50, // Set the width of the circle
                              height: 50, // Set the height of the circle
                              decoration: BoxDecoration(
                                shape:
                                    BoxShape.circle, // Make the shape circular
                                color: Colors
                                    .white, // Set the background color to white
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.1), // Warna bayangan, sesuaikan transparansinya
                                    offset: Offset(0,
                                        4), // Posisi bayangan (horizontal, vertikal)
                                    blurRadius: 8, // Jarak blur bayangan
                                    spreadRadius: 2, // Menyebarkan bayangan
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  ImageAssets
                                      .bni, // Ganti dengan path gambar Anda
                                  width:
                                      32, // Set the size of the image container
                                  height:
                                      32, // Set the size of the image container
                                  // Keep the image size as is (no resizing)
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Bank BNI",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              pushWithoutNavBar(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VirtualAccount(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50, // Set the width of the circle
                              height: 50, // Set the height of the circle
                              decoration: BoxDecoration(
                                shape:
                                    BoxShape.circle, // Make the shape circular
                                color: Colors
                                    .white, // Set the background color to white
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.1), // Warna bayangan, sesuaikan transparansinya
                                    offset: Offset(0,
                                        4), // Posisi bayangan (horizontal, vertikal)
                                    blurRadius: 8, // Jarak blur bayangan
                                    spreadRadius: 2, // Menyebarkan bayangan
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  ImageAssets
                                      .bri, // Ganti dengan path gambar Anda
                                  width:
                                      32, // Set the size of the image container
                                  height:
                                      32, // Set the size of the image container
                                  // Keep the image size as is (no resizing)
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Bank BRI",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              pushWithoutNavBar(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VirtualAccount(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50, // Set the width of the circle
                              height: 50, // Set the height of the circle
                              decoration: BoxDecoration(
                                shape:
                                    BoxShape.circle, // Make the shape circular
                                color: Colors
                                    .white, // Set the background color to white
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.1), // Warna bayangan, sesuaikan transparansinya
                                    offset: Offset(0,
                                        4), // Posisi bayangan (horizontal, vertikal)
                                    blurRadius: 8, // Jarak blur bayangan
                                    spreadRadius: 2, // Menyebarkan bayangan
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  ImageAssets
                                      .bca, // Ganti dengan path gambar Anda
                                  width:
                                      32, // Set the size of the image container
                                  height:
                                      32, // Set the size of the image container
                                  // Keep the image size as is (no resizing)
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Bank BCA",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              pushWithoutNavBar(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VirtualAccount(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "E-Wallet",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50, // Set the width of the circle
                              height: 50, // Set the height of the circle
                              decoration: BoxDecoration(
                                shape:
                                    BoxShape.circle, // Make the shape circular
                                color: Colors
                                    .white, // Set the background color to white
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.1), // Warna bayangan, sesuaikan transparansinya
                                    offset: Offset(0,
                                        4), // Posisi bayangan (horizontal, vertikal)
                                    blurRadius: 8, // Jarak blur bayangan
                                    spreadRadius: 2, // Menyebarkan bayangan
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  ImageAssets
                                      .gopay, // Ganti dengan path gambar Anda
                                  width:
                                      32, // Set the size of the image container
                                  height:
                                      32, // Set the size of the image container
                                  // Keep the image size as is (no resizing)
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Gopay",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              pushWithoutNavBar(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VirtualAccount(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
