import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/providers/home_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/utils/date.dart';
import 'package:agrolyn/views/chatbot/chatbot.dart';
import 'package:agrolyn/views/farmer/detection/detection_scan_screen.dart';
import 'package:agrolyn/views/farmer/home/detail_article.dart';
import 'package:agrolyn/views/farmer/olahans/category_olahan_page.dart';
import 'package:agrolyn/widgets/all_article_screen.dart';
import 'package:agrolyn/widgets/data_not_found.dart';
import 'package:agrolyn/widgets/no_found_custom.dart';
import 'package:agrolyn/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    initialize();
  }

  void initialize() async {
    String? res = await AuthService().refreshToken();
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeNotifier(context: context),
      child: Consumer<HomeNotifier>(builder: (context, value, child) {
        final weather = value.weathers.isNotEmpty ? value.weathers.first : null;

        return SafeArea(
          key: const Key('homePageMainWidget'),
          bottom: false,
          child: Scaffold(
            key: const Key('homePageMainWidget'),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            color: MyColors.primaryColorDark,
                            width: double.infinity,
                            height: 168,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 0, left: 16, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        ImageAssets.logo,
                                        height: 32,
                                        width: 32,
                                      ),
                                      const Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                "Tegal, Jawa Tengah",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Selamat Datang Di Agrolyn",
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Solusi Cerdas Pertanian Masa Depan",
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Lottie.asset(
                                        ImageAssets.videos,
                                        height: 92,
                                        width: 92,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 226,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.primaryColorDark,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 8, top: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Baca Artikel dan Video Edukasi yang menarik disini",
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          InkWell(
                                            key: const Key('selengkapnya'),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AllArticleScreen()),
                                              );
                                            },
                                            child: Container(
                                              height: 40,
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
                                                "Selengkapnya",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: MyColors
                                                        .primaryColorDark),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Divider(
                                              thickness: 3,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            weather != null
                                                ? "Suhu saat ini ${weather['temp']}°C"
                                                : "Suhu saat ini tidak tersedia",
                                            maxLines: 3,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    // Animasi Lottie
                                    // Animasi Lottie
                                    value.isLoading
                                        ? const CircularProgressIndicator() // Tampilkan indikator loading saat isLoading
                                        : weather == null
                                            ? DataNotFound(
                                                title: "Data Tidak Ditemukan",
                                                subtitle:
                                                    "Data cuaca tidak ditemukan",
                                              )
                                            : SizedBox(
                                                height: 192,
                                                width: 192,
                                                child: weather['temp'] < 28
                                                    ? Lottie.asset(
                                                        ImageAssets
                                                            .cloudy, // Ganti dengan path animasi hujan
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Lottie.asset(
                                                        ImageAssets
                                                            .cloud, // Ganti dengan path animasi cerah
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 226,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.primaryColorDark,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 8, top: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 192,
                                        width: 192,
                                        child: Image.asset(
                                          ImageAssets.piring1,
                                          fit: BoxFit.fill,
                                        )),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Buat ide usaha kamu menarik di Agrolyn Resep",
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 8, 0),
                                            child: InkWell(
                                              key: const Key('selengkapnya'),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CategoryOlahanPage(
                                                            idCat: 0,
                                                          )),
                                                );
                                              },
                                              child: Container(
                                                height: 40,
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
                                                      offset:
                                                          const Offset(0, 4),
                                                      blurRadius: 8,
                                                    ),
                                                  ],
                                                ),
                                                child: const Text(
                                                  "Selengkapnya",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: MyColors
                                                          .primaryColorDark),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0x20000000))),
                            margin: const EdgeInsets.fromLTRB(10, 8, 10, 16),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title Section
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "Kalkulator panen dan penghasilan Petani",
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: MyColors.primaryColorDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Form Fields
                                  Form(
                                    key: value.keyForm,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Dropdown for plant selection
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Pilih tanaman: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                DropdownButton<String>(
                                                  value: value
                                                          .selectedPlant.isEmpty
                                                      ? null
                                                      : value.selectedPlant,
                                                  onChanged:
                                                      (String? newValue) {
                                                    if (newValue != null) {
                                                      value.setChangePlant(
                                                          newValue);
                                                    }
                                                  },
                                                  items: <String>[
                                                    'corn',
                                                    'rice',
                                                    'tomato'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    String displayText;
                                                    switch (value) {
                                                      case 'corn':
                                                        displayText = 'Jagung';
                                                        break;
                                                      case 'rice':
                                                        displayText =
                                                            'Padi/Gabah';
                                                        break;
                                                      case 'tomato':
                                                        displayText = 'Tomat';
                                                        break;
                                                      default:
                                                        displayText = value;
                                                    }
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(displayText),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Input for price per kilogram
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: TextFormField(
                                              controller:
                                                  value.hargaPerKgController,
                                              decoration: const InputDecoration(
                                                labelText: 'Harga Per Kg',
                                                border: OutlineInputBorder(),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Masukkan harga per kg';
                                                }
                                                if (double.tryParse(value) ==
                                                    null) {
                                                  return 'Masukkan angka yang valid';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          // Input for field area
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: TextFormField(
                                              controller:
                                                  value.luasSawahController,
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Luas Sawah (m²/hektar)',
                                                border: OutlineInputBorder(),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Masukkan luas sawah';
                                                }
                                                if (double.tryParse(value) ==
                                                    null) {
                                                  return 'Masukkan angka yang valid';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          // Input for planting date using showDatePicker
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: GestureDetector(
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      value.tanggalTanam,
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (pickedDate != null &&
                                                    pickedDate !=
                                                        value.tanggalTanam) {
                                                  value.setUpdateTanggalTanam(
                                                      pickedDate);
                                                }
                                              },
                                              child: AbsorbPointer(
                                                child: TextFormField(
                                                  controller:
                                                      TextEditingController(
                                                    text: DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(
                                                            value.tanggalTanam),
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Tanggal Tanam',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  readOnly:
                                                      true, // Cannot type, only tap
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Button to submit the form

                                          value.isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    await value.submit();
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: double.infinity,
                                                    alignment: Alignment
                                                        .center, // Posisikan teks di tengah
                                                    decoration: BoxDecoration(
                                                      color: MyColors
                                                          .primaryColorDark,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          offset: const Offset(
                                                              0, 4),
                                                          blurRadius: 8,
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Text(
                                                      "Hitung",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, bottom: 8, right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.primaryColorDark,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0x20000000)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Hasil Perhitungan Panen dan Profit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    value.harvestData.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildResultRow(
                                                  'Jenis Tanaman:',
                                                  value.selectedPlant == 'corn'
                                                      ? 'Jagung'
                                                      : 'Beras'),
                                              _buildResultRow('Harga Per Kg:',
                                                  'Rp. ${value.hargaPerKg} /Kg'),
                                              _buildResultRow('Luas Sawah:',
                                                  '${value.luasSawah} m²'),
                                              _buildResultRow(
                                                  'Tanggal Tanam:',
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(
                                                          value.tanggalTanam)),
                                              const SizedBox(height: 16),
                                              ...value.harvestData.map((data) =>
                                                  _buildHarvestData(data)),
                                            ],
                                          )
                                        : const NoFoundCustomWhite(
                                            message:
                                                'Hasil perhitungan tidak ditemukan',
                                            subMessage:
                                                'Lakukan perhitungan dengan mengisi form terlebih dahulu',
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: SingleChildScrollView(
                              scrollDirection:
                                  Axis.horizontal, // Mengatur scroll horizontal
                              child: Row(
                                children: [],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, bottom: 8, right: 8),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: MyColors.primaryColorDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Artikel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white, // Menambahkan warna teks agar kontras
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllArticleScreen()),
                                        );
                                      },
                                      child: const Text(
                                        "Lihat lainnya",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors
                                              .white, // Mengubah warna teks menjadi putih
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: value.isLoading
                                ? const CircularProgressIndicator() // Tampilkan indikator loading saat isLoading
                                : value.articles.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, left: 0),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              var article =
                                                  value.articles[index];
                                              return InkWell(
                                                  onTap: () {
                                                    pushWithoutNavBar(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailArticle(
                                                                article:
                                                                    article),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    margin: const EdgeInsets
                                                        .only(
                                                        bottom:
                                                            8), // Memberikan sedikit jarak antar artikel
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                          blurRadius: 6,
                                                          spreadRadius: 2,
                                                          offset: const Offset(
                                                              0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        // Gambar thumbnail
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                            article[
                                                                'thumbnail'],
                                                            height: 100,
                                                            width: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 12),
                                                        // Kolom untuk teks (kategori, judul, waktu)
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .location_on_outlined,
                                                                      size: 11,
                                                                      color: Colors
                                                                          .grey),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    "${article['location']}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 2),
                                                              Text(
                                                                "${article['title']}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Text(
                                                                "${article['description']}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .calendar_month_outlined,
                                                                      size: 11,
                                                                      color: Colors
                                                                          .grey),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  FutureBuilder(
                                                                    future: formatRelativeTime(
                                                                        article[
                                                                            "released_date"]),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        return Text(
                                                                          snapshot
                                                                              .data
                                                                              .toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return const CircularProgressIndicator(); // or some other loading indicator
                                                                      }
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ));
                                            }),
                                      )
                                    : const Center(
                                        child: NoFoundCustomWhite(
                                          message: 'Artikel tidak ditemukan',
                                          subMessage:
                                              'Tidak ada artikel yang tersedia',
                                        ),
                                      ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, bottom: 8, right: 8),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: MyColors.primaryColorDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Video Edukasi",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white, // Menambahkan warna teks agar kontras
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllArticleScreen()),
                                        );
                                      },
                                      child: const Text(
                                        "Lihat lainnya",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors
                                              .white, // Mengubah warna teks menjadi putih
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: value.isLoading
                                ? const CircularProgressIndicator()
                                : value.videos.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          final video = value.videos[index];

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    16), // Atur jarak antar video
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5,
                                                  spreadRadius: 2,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Thumbnail video
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                  ),
                                                  child: Image.network(
                                                    video['thumbnail'],
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 150,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Judul video
                                                      Text(
                                                        video['title'],
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      // Deskripsi video
                                                      Text(
                                                        video['description'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),

                                                      InkWell(
                                                        onTap: () {
                                                          showVideoDialog(
                                                            context,
                                                            video['link_yt'],
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width:
                                                              double.infinity,
                                                          alignment: Alignment
                                                              .center, // Posisikan teks di tengah
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MyColors
                                                                .primaryColorDark, // Warna tombol
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Sudut melengkung
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.2),
                                                                offset:
                                                                    const Offset(
                                                                        0, 4),
                                                                blurRadius: 8,
                                                              ),
                                                            ],
                                                          ),
                                                          child: const Text(
                                                            "Lihat",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white, // Warna teks
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: NoFoundCustomWhite(
                                          message: 'Video tidak ditemukan',
                                          subMessage:
                                              'Video edukasi tidak tersedia',
                                        ),
                                      ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 138,
                        left: 8,
                        right: 8,
                        child: SingleChildScrollView(
                          scrollDirection:
                              Axis.horizontal, // Mengatur scroll horizontal
                          child: Row(
                            children: [
                              // Container pertama
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Padding di dalam container
                                height:
                                    64, // Menyesuaikan tinggi supaya lebih proporsional
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    )
                                  ],
                                  border: Border.all(
                                    color: MyColors.primaryColorDark.withOpacity(
                                        0.3), // Border dengan warna lebih menarik
                                    width: 1.5, // Lebar border yang pas
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('scan_type', "Padi");
                                    pushScreenWithoutNavBar(
                                        context, const DetectionScanScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Rata kiri untuk elemen pertama
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageAssets.logoPadi,
                                        height: 32,
                                        width: 32,
                                      ),
                                      const SizedBox(
                                          width:
                                              12), // Ruang antara gambar dan teks
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Padi",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight
                                                  .w600, // Font lebih tebal
                                            ),
                                          ),
                                          Text(
                                            "Deteksi Penyakit",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black.withOpacity(
                                                  0.7), // Warna lebih lembut
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              // Container kedua
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Padding di dalam container
                                height:
                                    64, // Menyesuaikan tinggi supaya lebih proporsional
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    )
                                  ],
                                  border: Border.all(
                                    color: MyColors.primaryColorDark.withOpacity(
                                        0.3), // Border dengan warna lebih menarik
                                    width: 1.5, // Lebar border yang pas
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('scan_type', "Jagung");
                                    pushScreenWithoutNavBar(
                                        context, const DetectionScanScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Rata kiri untuk elemen pertama
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageAssets.logoJagung,
                                        height: 32,
                                        width: 32,
                                      ),
                                      const SizedBox(
                                          width:
                                              12), // Ruang antara gambar dan teks
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Jagung",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight
                                                  .w600, // Font lebih tebal
                                            ),
                                          ),
                                          Text(
                                            "Deteksi Penyakit",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black.withOpacity(
                                                  0.7), // Warna lebih lembut
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              // Container keempat
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8), // Padding di dalam container
                                height:
                                    64, // Menyesuaikan tinggi supaya lebih proporsional
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    )
                                  ],
                                  border: Border.all(
                                    color: MyColors.primaryColorDark.withOpacity(
                                        0.3), // Border dengan warna lebih menarik
                                    width: 1.5, // Lebar border yang pas
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('scan_type', "Tomat");
                                    pushScreenWithoutNavBar(
                                        context, const DetectionScanScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Rata kiri untuk elemen pertama
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImageAssets.tomato,
                                        height: 32,
                                        width: 32,
                                      ),
                                      const SizedBox(
                                          width:
                                              12), // Ruang antara gambar dan teks
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tomat",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight
                                                  .w600, // Font lebih tebal
                                            ),
                                          ),
                                          Text(
                                            "Deteksi Penyakit",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black.withOpacity(
                                                  0.7), // Warna lebih lembut
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: value.chatbotPosition.dx,
                  top: value.chatbotPosition.dy,
                  child: Draggable(
                    feedback: Image.asset(
                      ImageAssets.logoChatbot,
                      height: 80,
                      width: 80,
                    ),
                    childWhenDragging:
                        Container(), // Widget shown when dragging
                    onDraggableCanceled: (velocity, offset) {
                      // Update position using the provider
                      value.updateChatbotPosition(offset);
                    },
                    child: InkWell(
                      onTap: () {
                        pushWithoutNavBar(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Chatbot(),
                          ),
                        );
                      },
                      child: Image.asset(
                        ImageAssets.logoChatbot,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget _buildResultRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _buildHarvestData(Map<String, dynamic> data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(color: Colors.white54),
      _buildResultRow('Sisa Hari:', '${data['sisa_hari']} Hari'),
      _buildResultRow('Tanggal Panen:', '${data['tanggal_panen']}'),
      _buildResultRow(
          'Total Harga Rupiah:', _formatRupiah(data['total_harga_rupiah'])),
      _buildResultRow('Total Hasil (Kg):',
          '${_formatNumber(data['total_hasil_kilogram'])} Kg / ${_formatNumber(data['total_hasil_ton'])} Ton'),
    ],
  );
}

String _formatRupiah(dynamic value) {
  if (value == null) return 'Rp. 0';

  // Convert to double jika berupa string
  double amount =
      value is String ? double.tryParse(value) ?? 0 : value.toDouble();

  // Format dengan NumberFormat untuk Rupiah Indonesia
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  return formatter.format(amount);
}

String _formatNumber(dynamic value) {
  if (value == null) return '0';

  // Convert to double jika berupa string
  double number =
      value is String ? double.tryParse(value) ?? 0 : value.toDouble();

  // Format dengan pemisah ribuan
  final formatter = NumberFormat('#,##0.##', 'id_ID');

  return formatter.format(number);
}
