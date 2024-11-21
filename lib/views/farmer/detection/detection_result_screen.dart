import 'package:agrolyn/providers/menu_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class DetectionResultScreen extends StatelessWidget {
  List<String> list = [
    "Penggunaan Varietas Tahan PenyakitPilih varietas padi yang memiliki ketahanan terhadap Hawar Daun Bakteri. Penggunaan varietas tahan adalah salah satu cara paling efektif untuk mengurangi risiko penyakit ini.",
    "Pengaturan Irigasi dan Drainase yang Baik, Hindari genangan air yang dapat meningkatkan kelembapan dan memudahkan penyebaran bakteri. Pastikan saluran drainase berfungsi dengan baik untuk mencegah air tergenang.",
    "Penggunaan Benih Sehat dan Bebas Penyakit Pilih benih yang sehat dan bebas dari kontaminasi penyakit. Benih yang terinfeksi dapat menjadi sumber utama penyebaran penyakit ini.",
    "Sanitasi dan Pemangkasan Daun Terinfeksi. Potong daun yang terinfeksi untuk mengurangi sumber infeksi. Buang daun terinfeksi jauh dari lahan tanam agar tidak menyebar ke tanaman lain.",
    "Penggunaan Bakterisida Sesuai Anjuran. Jika serangan sudah meluas, aplikasi bakterisida dapat digunakan"
  ];

  DetectionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hasil Deteksi"),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ChangeNotifierProvider(
            create: (_) => MenuNotifier(context: context),
            child: Consumer<MenuNotifier>(
                builder: (context, value, child) => SafeArea(
                      bottom: false,
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: MyColors.primaryColorDark),
                                    child: const Text(
                                        "Hawar Daun Bakteri (Bacterial Leaf Blight)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white)),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      ImageAssets.dummyResult,
                                      width: double.infinity,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                      'Disebabkan oleh bakteri Xanthomonas oryzae, menyebabkan daun padi menjadi kuning dan layu. Penyakit ini dapat mengakibatkan penurunan hasil panen yang signifikan'),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    "Penanganan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                              "${index + 1}. ${list[index]}"));
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        minimumSize: WidgetStateProperty.all(
                                            const Size(double.maxFinite, 50)),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                MyColors.primaryColorDark),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        PersistentTabController toPage =
                                            PersistentTabController(
                                                initialIndex: 3);
                                        pushWithNavBar(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Menu(page: toPage)));
                                      },
                                      child: const Text(
                                          "Diskusikan Lebih lanjut di Komunitas",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16))),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        minimumSize: WidgetStateProperty.all(
                                            const Size(double.maxFinite, 50)),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                MyColors.primaryColorDark),
                                        side: WidgetStateProperty.all(
                                            const BorderSide(
                                                width: 1,
                                                color:
                                                    MyColors.primaryColorDark)),
                                      ),
                                      onPressed: () {
                                        pushWithNavBar(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Menu()));
                                      },
                                      child: const Text("Kembali Ke Beranda",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)))
                                ]),
                          )),
                    ))));
  }
}
