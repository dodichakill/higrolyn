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
  const EditProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(builder: (context, value, child) {
        Future<void> loadProduct() async {
          value.nameEditingController.text = product['name'].toString();
          value.descEditingController.text = product['description'].toString();
          value.priceEditingController.text = product['price'].toString();
          value.stockEditingController.text = product['stock'].toString();
          value.categoryProductController.text =
              product['category']['name'].toString();
          value.setImageProductDefault(product['image']);
        }

        Future<void> saveProduk() async {
          if (value.keyfrom.currentState?.validate() ?? false) {
            value.setLoading(true);

            // Retrieve data from the form to send to API
            String name = value.nameEditingController.text;
            String desc = value.descEditingController.text;
            int price = int.tryParse(value.priceEditingController.text) ?? 0;
            int stock = int.tryParse(value.stockEditingController.text) ?? 0;
            String category = value.categoryProductController.text;

            // Log data that will be sent
            print("Name: $name");
            print("Description: $desc");
            print("Price: $price");
            print("Stock: $stock");
            print("Category: $category");
            print(
                "Image Path: ${value.imageProduct?.path ?? 'No image selected'}");

            // Send data to the API
            final res = await StoreService().updateProduct(
              context,
              product['id'],
              name,
              desc,
              price,
              stock,
              category,
              value.imageProduct != null
                  ? File(value.imageProduct!.path)
                  : File(''), // For the image file
            );

            if (res == true) {
              value.setLoading(false);
            } else {
              value.setLoading(false);
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Produk'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
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
                          controller: value.nameEditingController,
                          decoration: InputDecoration(
                            labelText: "Nama produk",
                          ),
                          validator: (e) => e!.isEmpty
                              ? "Nama produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: value.descEditingController,
                          decoration:
                              InputDecoration(labelText: "Deskripsi produk"),
                          validator: (e) => e!.isEmpty
                              ? "Deskripsi produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: value.priceEditingController,
                          decoration:
                              InputDecoration(labelText: "Harga produk"),
                          validator: (e) => e!.isEmpty
                              ? "Harga produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: value.stockEditingController,
                          decoration: InputDecoration(
                            labelText: "Stok produk",
                          ),
                          validator: (e) => e!.isEmpty
                              ? "Stok produk tidak boleh kosong"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownCategoryStore(),
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
                                  child: Image.file(value.imageProduct!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => saveProduk(),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.primaryColorDark),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            minimumSize:
                                MaterialStateProperty.all(Size(180, 40)),
                          ),
                          child: value.isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('Simpan'),
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
