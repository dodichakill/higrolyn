import 'dart:io';

import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/providers/store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/widgets/dropdown_category_store.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormProduct extends StatelessWidget {
  const FormProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(builder: (context, value, child) {
        Future<void> _submitForm(BuildContext context) async {
          if (value.keyfrom.currentState!.validate() &&
              value.imageProduct != null) {
            value.setLoading(true);
            value.setNameProduct(value.nameEditingController.text);
            value.setDescProduct(value.descEditingController.text);
            value.setPriceProduct(int.parse(value.priceEditingController.text));
            value.setStockProduct(int.parse(value.stockEditingController.text));
            value.selectCategoryProduct(value.categoryProductController.text);

            final file = File(value.imageProduct!.path);
            if (await file.exists()) {
              final formData = FormData.fromMap({
                "product_name": value.nameProduct,
                "desc_product": value.descProduct,
                "price": value.priceProduct,
                "stock": value.stockProduct,
                "product_categories_id":
                    value.categoryIdProduct.toString(), // Convert to String
                "img_product":
                    await MultipartFile.fromFile(value.imageProduct!.path),
              });
              await StoreService().fetchNewProduct(formData).then((result) {
                value.setLoading(false);
                if (result == "Produk berhasil ditambahkan") {
                  Navigator.pop(context, true);
                  showCustomSnackbar(context, "Berhasil Ditambahkan",
                      "Produk Berhasil Di tambahkan", ContentType.success);
                } else {
                  showCustomSnackbar(context, "Berhasil ditambahkan",
                      "Produk Berhasil Ditambahkan", ContentType.success);
                  Navigator.pop(context, true);
                }
              }).catchError((error) {
                value.setLoading(false);
                showCustomSnackbar(context, "Error",
                    "Terjadi kesalahan: $error", ContentType.failure);
                print("Error: $error");
              });
            } else {
              value.setLoading(false);
              showCustomSnackbar(
                  context,
                  "Error",
                  "File tidak ditemukan atau tidak dapat diakses",
                  ContentType.failure);
            }
          } else {
            showCustomSnackbar(
                context,
                "Error",
                "Form tidak valid atau gambar tidak dipilih",
                ContentType.failure);
          }
        }

        return Scaffold(
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
                              DropdownCategoryStore()
                            ],
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => value.pickImage(context),
                            child: value.imageProduct == null
                                ? Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.grey[300],
                                    ),
                                    child: Icon(Icons.add_a_photo,
                                        color: Colors.grey[500]),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      value.imageProduct!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _submitForm(context),
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    MyColors.primaryColorDark),
                                foregroundColor:
                                    WidgetStateProperty.all(Colors.white),
                                minimumSize:
                                    WidgetStateProperty.all(Size(180, 40))),
                            child: const Text('Simpan'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
