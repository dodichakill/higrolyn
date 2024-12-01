import 'dart:io';

import 'package:agrolyn/api/community_service.dart';
import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/shared/custom_snackbar.dart';
import 'package:agrolyn/utils/assets_path.dart';
import 'package:agrolyn/views/farmer/comunity/detail_community_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:agrolyn/views/farmer/comunity/community_screen.dart';
import 'package:agrolyn/widgets/dropdown_category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class EditQuestion extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  int id;

  EditQuestion({super.key, required this.id});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      context.read<CommunityNotifer>().setImageQuestion(File(pickedFile.path));
    }
  }

  Future<void> _submitForm(BuildContext context) async {
    final provider = context.read<CommunityNotifer>();

    if (_formKey.currentState!.validate()) {
      final formData = FormData.fromMap({
        'title_q': provider.titleQuestion,
        'description': provider.descriptionQuestion,
        'plant_types_id': provider.categoryIdQuestion,
        if (provider.imageQuestion != null)
          'img_q': await MultipartFile.fromFile(provider.imageQuestion!.path,
              filename: 'img-question.jpg'),
      });

      await CommunityService().fetchEditQuestion(id, formData).whenComplete(() {
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCommunityScreen(
                      id: id,
                    )));
        showCustomSnackbar(context, "Berhasil Diperbarui",
            "Jawaban Anda Berhasil Diperbarui!", ContentType.success);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CommunityNotifer>();

    return Scaffold(
        body: Center(
            child: Material(
                borderRadius: BorderRadius.circular(16),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(ImageAssets.question),
                              ),
                              const SizedBox(height: 20),
                              const Center(
                                child: Text(
                                  "Edit Pertanyaan",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Input title
                              TextFormField(
                                initialValue: provider.titleQuestion,
                                decoration: InputDecoration(
                                  labelText: "Judul",
                                  focusColor: MyColors.primaryColorDark,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onChanged: (value) =>
                                    provider.setTitleQuestion(value),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Title is required'
                                        : null,
                              ),
                              const SizedBox(height: 16),
                              // Input description
                              TextFormField(
                                initialValue: provider.descriptionQuestion,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  labelText: "Deskripsi",
                                  focusColor: MyColors.primaryColorDark,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onChanged: (value) =>
                                    provider.setDescriptionQuestion(value),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Description is required'
                                        : null,
                              ),
                              const SizedBox(height: 16),
                              // Image picker
                              GestureDetector(
                                onTap: () => _pickImage(context),
                                child: provider.imageQuestionDefault!.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          provider.imageQuestionDefault!,
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : provider.imageQuestion == null
                                        ? Container(
                                            height: 150,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: Colors.grey[300],
                                            ),
                                            child: Icon(Icons.add_a_photo,
                                                color: Colors.grey[500]),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.file(
                                              provider.imageQuestion!,
                                              height: 150,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                              const SizedBox(height: 16),
                              const Row(
                                children: [
                                  Text("Pilih Kategori : "),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  DropdownCategory(),
                                ],
                              ),
                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red),
                                          foregroundColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.white),
                                          minimumSize:
                                              const WidgetStatePropertyAll(
                                                  Size(180, 40))),
                                      child: const Text('Batal')),
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () => _submitForm(context),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                MyColors.primaryColorDark),
                                        foregroundColor:
                                            const WidgetStatePropertyAll(
                                                Colors.white),
                                        minimumSize:
                                            const WidgetStatePropertyAll(
                                                Size(180, 40))),
                                    child: const Text('Simpan'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}
