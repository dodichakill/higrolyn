import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/providers/store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/auth/register_screen.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormProduct extends StatelessWidget {
  const FormProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(
        builder: (context, value, child) => Scaffold(
          body: Form(
            key: value.keyfrom,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 32),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back)),
                                Text(
                                  'Manajemen Produk',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: value.nameEditingController,
                            decoration: InputDecoration(
                              labelText: 'Nama Produk',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null; // Mengembalikan null jika valid
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: value.descEditingController,
                            decoration: InputDecoration(
                              labelText: 'Deskripsi Produk',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null; // Mengembalikan null jika valid
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: value.priceEditingController,
                            decoration: InputDecoration(
                              labelText: 'Harga Produk',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null; // Mengembalikan null jika valid
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: value.stockEditingController,
                            decoration: InputDecoration(
                              labelText: 'Stok Produk',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null; // Mengembalikan null jika valid
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: value.categoryEditingController,
                            decoration: InputDecoration(
                              labelText: 'Kategori Produk',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Tidak Boleh Kosong";
                              }
                              return null; // Mengembalikan null jika valid
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(4),
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: MyColors.primaryColorDark,
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Pilih Foto Produk",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  // Menggunakan ImagePicker untuk memilih gambar dari galeri
                                  final picker = ImagePicker();
                                  final XFile? pickedFile = await picker
                                      .pickImage(source: ImageSource.gallery);

                                  if (pickedFile != null) {
                                    // Menampilkan path gambar yang dipilih pada TextFormField
                                    value.imgEditingController.text =
                                        pickedFile.path;
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 136, // Lebar tetap untuk tombol
                                  alignment: Alignment
                                      .center, // Posisikan teks di tengah
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Warna tombol
                                    borderRadius: BorderRadius.circular(
                                        8), // Sudut melengkung
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 4),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    "Tambah Produk",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors
                                          .primaryColorDark, // Warna teks
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Section: Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (value.keyfrom.currentState!.validate()) {
                              value.setLoading(true);
                              StoreService()
                                  .createProduct(
                                      context,
                                      value.nameEditingController.text,
                                      value.descEditingController.text,
                                      value.priceEditingController.text as int,
                                      value.stockEditingController.text as int,
                                      value.categoryEditingController.text,
                                      value.imgEditingController.text)
                                  .whenComplete(() => value.setLoading(false));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: value.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Tambah',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
