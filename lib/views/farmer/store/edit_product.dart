import 'dart:io';
import 'package:agrolyn/api/store_service.dart';
import 'package:agrolyn/providers/store_notifier.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/widgets/dropdown_category_store.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/custom_snackbar.dart';
import 'package:dio/dio.dart';

class EditProduct extends StatelessWidget {
  final Map<String, dynamic> product;
  EditProduct({super.key, required this.product}) {
    print(product);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(builder: (context, value, child) {
        Future<void> saveProduk() async {
          if (value.keyfrom.currentState?.validate() ?? false) {
            value.setLoading(true);
            value.notifyListeners();

            // Send data to the API
            final res = await StoreService()
                .updateProduct(
              context,
              product['id'],
              value.nameProduct,
              value.descProduct,
              value.priceProduct,
              value.stockProduct,
              value.categoryIdProduct.toString(),
              value.imageProduct != null
                  ? File(value.imageProduct!.path)
                  : File(''), // For the image file
            )
                .whenComplete(() {
              value.setLoading(false);
              value.notifyListeners();
            });
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Produk'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Form(
            key: value.keyfrom,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: product['product_name'],
                          decoration: const InputDecoration(
                            labelText: "Nama produk",
                          ),
                          onChanged: (e) => value.setNameProduct(e),
                          validator: (e) => e!.isEmpty
                              ? "Nama produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: product['desc_product'],
                          decoration: const InputDecoration(
                              labelText: "Deskripsi produk"),
                          onChanged: (e) => value.setDescProduct(e),
                          validator: (e) => e!.isEmpty
                              ? "Deskripsi produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: product['price'].toString(),
                          onChanged: (e) => value.setPriceProduct(int.parse(e)),
                          decoration:
                              const InputDecoration(labelText: "Harga produk"),
                          validator: (e) => e!.isEmpty
                              ? "Harga produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: product['stock'].toString(),
                          onChanged: (e) => value.setStockProduct(int.parse(e)),
                          decoration: const InputDecoration(
                            labelText: "Stok produk",
                          ),
                          validator: (e) => e!.isEmpty
                              ? "Stok produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        const DropdownCategoryStore(),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => value.pickImage(context),
                          child: value.imageProduct != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(value.imageProduct!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                )
                              : product['img_product'] != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        product['img_product'],
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.grey[300],
                                      ),
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.grey[500]),
                                    ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => saveProduk(),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                MyColors.primaryColorDark),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            minimumSize:
                                WidgetStateProperty.all(const Size(180, 40)),
                          ),
                          child: value.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text('Simpan'),
                        ),
                      ],
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
