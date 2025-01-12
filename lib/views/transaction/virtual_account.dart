import 'package:agrolyn/providers/store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VirtualAccount extends StatelessWidget {
  const VirtualAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Virtual Account',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mohon segera lakukan pembayaran",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 316,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:
                            Colors.white, // Set the background color to white
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.1), // Warna bayangan, sesuaikan transparansinya
                            offset: Offset(
                                0, 4), // Posisi bayangan (horizontal, vertikal)
                            blurRadius: 8, // Jarak blur bayangan
                            spreadRadius: 2, // Menyebarkan bayangan
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50, // Set the width of the circle
                                  height: 50, // Set the height of the circle
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Make the shape circular
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
                                TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        "Ganti",
                                        style: TextStyle(
                                            color: MyColors.primaryColorDark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        color: MyColors.primaryColorDark,
                                        Icons.arrow_forward_ios_outlined,
                                        size: 14,
                                      ), // Icon panah
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "BRI Virtual Account Anumber",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double
                                  .infinity, // Set the width of the circle
                              height: 54, // Set the height of the circle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    8), // Make the shape circular
                                color: Colors.grey[
                                    350], // Set the background color to white
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
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "1234567890",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Menyalin teks ke clipboard
                                        Clipboard.setData(ClipboardData(
                                                text: "1234567890"))
                                            .then((_) {
                                          // Menampilkan snack bar sebagai feedback setelah menyalin
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Nomor berhasil disalin!'),
                                            ),
                                          );
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide(
                                            color: MyColors.primaryColorDark,
                                            width: 2), // Border warna biru
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8), // Padding tombol
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8), // Rounded corners
                                        ),
                                      ),
                                      child: Text(
                                        "Salin",
                                        style: TextStyle(
                                            color: MyColors.primaryColorDark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "BRI Virtual Account Anumber",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double
                                  .infinity, // Set the width of the circle
                              height: 54, // Set the height of the circle
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    8), // Make the shape circular
                                color: Colors.grey[
                                    350], // Set the background color to white
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
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dodi Trisnato Wicaksono Pratama",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text("Cara Pembayaran",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 16,
                    ),
                    ExpansionTile(
                      title: Text(
                        'ATM',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Masukkan Kartu ATM: Masukkan kartu ATM Anda ke mesin ATM.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Pilih Bahasa: Pilih bahasa yang Anda inginkan di layar mesin ATM.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Masukkan PIN ATM: Masukkan PIN ATM Anda untuk mengakses transaksi.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Pilih Transaksi Lain: Pilih menu "Transaksi Lain" di layar mesin ATM.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Pilih Pembayaran: Pilih opsi "Pembayaran" untuk melakukan pembayaran.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Pilih Menu "Lainnya": Pilih menu "Lainnya" untuk melanjutkan ke pembayaran melalui Virtual Account.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Masukkan Nomor Virtual Account: Masukkan nomor Virtual Account yang telah diberikan.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Masukkan Jumlah Pembayaran: Masukkan jumlah yang ingin Anda bayarkan.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Periksa Data Transaksi: Pastikan data transaksi yang Anda masukkan sudah benar.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Konfirmasi Pembayaran: Tekan tombol "YA" untuk mengonfirmasi pembayaran dan selesaikan transaksi.'),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        'Mobile Banking',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Buka aplikasi mobile banking (M-Banking) yang Anda miliki di ponsel.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Masukkan username dan PIN atau menggunakan autentikasi biometrik (sidik jari atau wajah) untuk login ke aplikasi.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Di halaman utama aplikasi, pilih menu "Pembayaran" atau "Top Up" sesuai dengan layanan yang Anda ingin gunakan.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Pilih opsi "Pembayaran Lainnya" jika tidak menemukan opsi langsung untuk pembayaran yang Anda tuju.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Pilih jenis pembayaran yang sesuai dengan yang Anda ingin lakukan (misalnya "Briva" untuk pembayaran Virtual Account).'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Masukkan nomor Virtual Account yang diberikan kepada Anda.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Masukkan jumlah uang yang ingin Anda bayar sesuai dengan tagihan yang tertera.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Periksa kembali semua informasi transaksi yang tampil, seperti nomor Virtual Account dan jumlah pembayaran.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Setelah memeriksa data, tekan tombol "Konfirmasi" atau "YA" untuk melanjutkan transaksi.'),
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.circle, size: 10, color: Colors.black),
                          title: Text(
                              'Tunggu beberapa saat hingga transaksi Anda diproses dan berhasil. Anda akan menerima notifikasi atau bukti transaksi.'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
