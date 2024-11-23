import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailCommunity extends StatelessWidget {
  const DetailCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityNotifer(context: context),
      child: Consumer<CommunityNotifer>(
        builder: (context, value, child) => Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Bagian gambar
                          Stack(children: [
                            Image.asset(
                              ImageAssets.petaniComunity,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 256,
                            ),
                          ]),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Informasi pengguna
                                Row(
                                  children: [
                                    Icon(Icons.person, size: 24),
                                    SizedBox(width: 8),
                                    Text(
                                      "User123",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "#Padi",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                // Pertanyaan
                                Text(
                                  "Bagaimana cara meningkatkan produktivitas padi secara organik secara efektif dan efisien?",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 16),
                                // Bagian tombol interaksi
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.thumb_up_alt_outlined,
                                            size: 16),
                                        SizedBox(width: 4),
                                        Text("Dukung Naik - 150"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.comment, size: 16),
                                        SizedBox(width: 4),
                                        Text("24 Jawaban"),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  color: MyColors.primaryColorDark,
                                ),

                                Text(
                                  "Jawaban",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: AssetImage(
                                          'assets/avatar.jpg'), // Ganti dengan path gambar Anda
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      // Expanded digunakan di sini agar teks mengambil lebar yang tersedia
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "John Doe",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "libero eget convallis fringilla, lectus magna pulvinar massa, eget euismod purus ligula a neque. Aliquam erat volutpat. Aenean justo purus",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                            ),
                                            softWrap: true,
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.thumb_up_alt_outlined,
                                                  size: 16),
                                              SizedBox(width: 4),
                                              Text("Dukung Naik - 150"),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Icon(
                                                  Icons.thumb_down_alt_outlined,
                                                  size: 16),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: AssetImage(
                                          'assets/avatar.jpg'), // Ganti dengan path gambar Anda
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      // Expanded digunakan di sini agar teks mengambil lebar yang tersedia
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "John Doe",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "libero eget convallis fringilla, lectus magna pulvinar massa, eget euismod purus ligula a neque. Aliquam erat volutpat. Aenean justo purus",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                            ),
                                            softWrap: true,
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.thumb_up_alt_outlined,
                                                  size: 16),
                                              SizedBox(width: 4),
                                              Text("Dukung Naik - 150"),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Icon(
                                                  Icons.thumb_down_alt_outlined,
                                                  size: 16),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: AssetImage(
                                          'assets/avatar.jpg'), // Ganti dengan path gambar Anda
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      // Expanded digunakan di sini agar teks mengambil lebar yang tersedia
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "John Doe",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "libero eget convallis fringilla, lectus magna pulvinar massa, eget euismod purus ligula a neque. Aliquam erat volutpat. Aenean justo purus",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                            ),
                                            softWrap: true,
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.thumb_up_alt_outlined,
                                                  size: 16),
                                              SizedBox(width: 4),
                                              Text("Dukung Naik - 150"),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Icon(
                                                  Icons.thumb_down_alt_outlined,
                                                  size: 16),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                            width: 44,
                            height: 44,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Kembali Ke Halaman Utama",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
