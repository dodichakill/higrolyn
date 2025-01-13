import 'package:agrolyn/api/detection_service.dart';
import 'package:agrolyn/providers/detection_notifier.dart';
import 'package:agrolyn/providers/menu_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:agrolyn/widgets/no_found_custom.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class DetailHistoryScanScreen extends StatelessWidget {
  List<String> list = [
    "Penggunaan Varietas Tahan PenyakitPilih varietas padi yang memiliki ketahanan terhadap Hawar Daun Bakteri. Penggunaan varietas tahan adalah salah satu cara paling efektif untuk mengurangi risiko penyakit ini.",
    "Pengaturan Irigasi dan Drainase yang Baik, Hindari genangan air yang dapat meningkatkan kelembapan dan memudahkan penyebaran bakteri. Pastikan saluran drainase berfungsi dengan baik untuk mencegah air tergenang.",
    "Penggunaan Benih Sehat dan Bebas Penyakit Pilih benih yang sehat dan bebas dari kontaminasi penyakit. Benih yang terinfeksi dapat menjadi sumber utama penyebaran penyakit ini.",
    "Sanitasi dan Pemangkasan Daun Terinfeksi. Potong daun yang terinfeksi untuk mengurangi sumber infeksi. Buang daun terinfeksi jauh dari lahan tanam agar tidak menyebar ke tanaman lain.",
    "Penggunaan Bakterisida Sesuai Anjuran. Jika serangan sudah meluas, aplikasi bakterisida dapat digunakan"
  ];
  final int id;
  DetailHistoryScanScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Hasil Deteksi"),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ChangeNotifierProvider(
            create: (_) => DetectionNotifier(
                context: context, page: 'detail-history', idHistory: id),
            child: Consumer<DetectionNotifier>(
                builder: (context, value, child) => value.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SafeArea(
                        bottom: false,
                        child: value.detailHistoryResult.isEmpty
                            ? Center(
                                child: NoFoundCustom(
                                message: "Hasil Deteksi Gagal",
                                subMessage:
                                    "Tidak ada hasil deteksi yang ditemukan",
                              ))
                            : SingleChildScrollView(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              const TextSpan(
                                                  text:
                                                      "Wah sayang sekali tanaman kamu terkena penyakit "),
                                              TextSpan(
                                                text: value.detailHistoryResult[
                                                    'disease_indonesian_name'],
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    decorationColor:
                                                        Colors.green,
                                                    decorationThickness: 2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const TextSpan(
                                                  text:
                                                      " Dari hasil deteksi Agrolyn"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                            "https://agrolyn.online/static/uploads/${value.detailHistoryResult['image_detection']}",
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: MyColors
                                                            .primaryColorDark),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color: Colors.white),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text("Bahasa Indonesia",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16,
                                                            color: MyColors
                                                                .primaryColorDark)),
                                                    Text(
                                                        value.detailHistoryResult[
                                                            'disease_indonesian_name'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color: MyColors
                                                                .primaryColorDark)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color: MyColors
                                                        .primaryColorDark),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text("Bahasa Latin",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white)),
                                                    Text(
                                                        value.detailHistoryResult[
                                                            'disease_name'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex:
                                                  1, // Atur proporsi untuk Container dengan Lottie
                                              child: Container(
                                                alignment: Alignment
                                                    .center, // Opsional: untuk memastikan posisi konten di tengah
                                                child: Lottie.asset(
                                                  ImageAssets
                                                      .questionTandaTanya,
                                                  height:
                                                      200, // Anda bisa menggunakan nilai fleksibel juga
                                                  width: 200,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex:
                                                  2, // Atur proporsi untuk RichText
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                        8.0), // Tambahkan sedikit padding
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      const TextSpan(
                                                          text: "Apasih "),
                                                      TextSpan(
                                                        text: value
                                                                .detailHistoryResult[
                                                            'disease_indonesian_name'],
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                          decorationColor:
                                                              Colors.green,
                                                          decorationThickness:
                                                              2,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                          text: " itu?"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          value.detailHistoryResult[
                                              "description"],
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Divider(),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Align(
                                          alignment: Alignment
                                              .center, // Mengatur RichText di tengah
                                          child: RichText(
                                            textAlign: TextAlign
                                                .center, // Atur teks agar rata tengah
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                const TextSpan(
                                                  text:
                                                      "Nah apa sih Penanganan dari  ",
                                                ),
                                                TextSpan(
                                                  text: value
                                                          .detailHistoryResult[
                                                      'disease_indonesian_name'],
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    decorationColor:
                                                        Colors.green,
                                                    decorationThickness: 2,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          value.detailHistoryResult["handling"],
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: InkWell(
                                            onTap: () {
                                              PersistentTabController toPage =
                                                  PersistentTabController(
                                                      initialIndex: 3);
                                              pushWithNavBar(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Menu(page: toPage)));
                                            },
                                            child: Container(
                                              height: 55,
                                              width: double.infinity,
                                              alignment: Alignment
                                                  .center, // Posisikan teks di tengah
                                              decoration: BoxDecoration(
                                                color:
                                                    MyColors.primaryColorDark,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 8,
                                                  ),
                                                ],
                                              ),
                                              child: const Text(
                                                "Diskusikan Lebih lanjut di Komunitas",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: InkWell(
                                            onTap: () {
                                              pushWithNavBar(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Menu()));
                                            },
                                            child: Container(
                                              height: 55,
                                              width: double.infinity,
                                              alignment: Alignment
                                                  .center, // Posisikan teks di tengah
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 8,
                                                  ),
                                                ],
                                              ),
                                              child: const Text(
                                                "Kembali Ke Beranda",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: MyColors
                                                        .primaryColorDark),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                )),
                      ))));
  }
}
