import 'dart:io';

import 'package:agrolyn/api/auth_service.dart';
import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/providers/store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/widgets/menu.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                  return null;
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
                                  return null;
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
                                keyboardType: TextInputType.number,
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
                                  return null;
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
                                keyboardType: TextInputType.number,
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
                                  return null;
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Kategori Produk',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Kategori Produk harus dipilih";
                                  }
                                  return null;
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'mentah',
                                    child: Text('Mentah'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'olahan',
                                    child: Text('Olahan'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'lainnya',
                                    child: Text('Lainnya'),
                                  ),
                                ],
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    value.categoryEditingController.text =
                                        newValue;
                                  } else {
                                    // Set default value if newValue is null, for instance
                                    value.categoryEditingController.text =
                                        'mentah'; // Set default category
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(4),
                            height: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: MyColors.primaryColorDark,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      final XFile? pickedFile =
                                          await picker.pickImage(
                                              source: ImageSource.gallery);

                                      if (pickedFile != null) {
                                        // Menampilkan path gambar yang dipilih pada TextFormField
                                        value.imgEditingController.text =
                                            pickedFile.path;
                                        value.notifyListeners();
                                      }
                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (value.imgEditingController.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Image.file(
                                File(value.imgEditingController.text),
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: value.isLoading
                                ? null // Disable the button if loading
                                : () async {
                                    if (value.keyfrom.currentState!
                                        .validate()) {
                                      // Ambil form values
                                      final productName =
                                          value.nameEditingController.text;
                                      final productDesc =
                                          value.descEditingController.text;
                                      final productPrice = int.parse(
                                          value.priceEditingController.text);
                                      final productStock = int.parse(
                                          value.stockEditingController.text);
                                      final productCategory =
                                          value.categoryEditingController.text;
                                      final productImage =
                                          value.imgEditingController.text;

                                      // Memanggil fungsi untuk membuat produk baru
                                      await value.CreateProduct(
                                        product_name: productName,
                                        desc_product: productDesc,
                                        price: productPrice,
                                        stock: productStock,
                                        product_categories_id: productCategory,
                                        img_product: productImage,
                                      );

                                      // Menampilkan snackbar jika produk berhasil ditambahkan
                                      if (!value.isLoading) {
                                        showCustomSnackbar(
                                            context,
                                            "Berhasil",
                                            "Produk Anda telah berhasil ditambahkan!",
                                            ContentType.success);
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColorDark,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: value.isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Tambah Produk',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
        ),
      ),
    );
  }
}
