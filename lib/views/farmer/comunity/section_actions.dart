import 'package:agrolyn/views/farmer/comunity/add_question.dart';
import 'package:agrolyn/views/farmer/comunity/upload_image_field.dart';
import 'package:agrolyn/widgets/dropdown_category.dart';
import 'package:flutter/material.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/providers/community_notifer.dart';
import 'package:provider/provider.dart';

class SectionActions extends StatelessWidget {
  const SectionActions({super.key});

  @override
  Widget build(BuildContext context) {
    void addQuestion(value) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return Center(
          //     child: Material(
          //   borderRadius: BorderRadius.circular(16),
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //         top: 32, bottom: 32, left: 16, right: 16),
          //     child: Container(
          //       constraints: const BoxConstraints(maxWidth: 400),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Center(
          //             child: Text(
          //               "Buat Diskusi Baru",
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.black),
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 16,
          //           ),
          //           const SizedBox(
          //             height: 12,
          //           ),
          //           TextFormField(
          //             decoration: const InputDecoration(
          //               labelText: 'Judul',
          //               border: OutlineInputBorder(),
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 12,
          //           ),
          //           TextFormField(
          //             maxLines: 7,
          //             decoration: const InputDecoration(
          //               labelText: 'Deskripsi',
          //               border: OutlineInputBorder(),
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 12,
          //           ),
          //           const UploadImageField(),
          //           const SizedBox(
          //             height: 12,
          //           ),
          //           const Row(
          //             children: [
          //               Text("Pilih Kategori : "),
          //               SizedBox(
          //                 width: 8,
          //               ),
          //               DropdownCategory(),
          //             ],
          //           ),
          //           const SizedBox(
          //             height: 16,
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               InkWell(
          //                 onTap: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: Container(
          //                   height: 48,
          //                   width: 184,
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(16),
          //                       color: Colors.red),
          //                   child: const Center(
          //                     child: Text(
          //                       "Batal",
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.white),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               InkWell(
          //                 onTap: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: Container(
          //                   height: 48,
          //                   width: 184,
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(16),
          //                       color: MyColors.primaryColorDark),
          //                   child: const Center(
          //                     child: Text(
          //                       "Kirim",
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.white),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ));
          return ChangeNotifierProvider(
            create: (_) => CommunityNotifer(context: context),
            builder: (context, child) => AddQuestion(),
          );
        },
      );
    }

    return ChangeNotifierProvider(
        create: (_) => CommunityNotifer(context: context),
        child: Consumer<CommunityNotifer>(
            builder: (context, value, child) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          // Search Bar
                          Expanded(
                            child: Container(
                              height: 48,
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
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: "Cari topik diskusimu disini",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Filter Question
                          Container(
                            height: 48,
                            width:
                                48, // Tetapkan lebar agar tombol add terlihat simetris
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: MyColors.primaryColorDark,
                            ),
                            child: const Icon(
                              Icons.filter_alt_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Add Question
                          InkWell(
                            onTap: () => addQuestion(value),
                            child: Container(
                              height: 48,
                              width:
                                  48, // Tetapkan lebar agar tombol add terlihat simetris
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: MyColors.primaryColorDark,
                              ),
                              child: const Icon(
                                Icons.add_circle,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
  }
}

class Option {
  String id;
  String name;

  Option({required this.id, required this.name});
}
