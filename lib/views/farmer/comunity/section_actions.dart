import 'package:agrolyn/views/farmer/comunity/add_question.dart';
import 'package:agrolyn/views/farmer/comunity/item_filter.dart';
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
          return ChangeNotifierProvider(
            create: (_) => CommunityNotifer(context: context),
            builder: (context, child) => AddQuestion(),
          );
        },
      );
    }

    void filterQuestion(value) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ChangeNotifierProvider(
                create: (_) => CommunityNotifer(context: context),
                builder: (context, child) => Center(
                        child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Filter Berdasarkan",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text("Kategori Tanaman",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  children: [
                                    ItemFilter(name: "Semua", onTap: () {}),
                                    ItemFilter(name: "Jagung", onTap: () {}),
                                    ItemFilter(name: "Padi", onTap: () {}),
                                  ],
                                ),
                                const Text("Lainnya",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  children: [
                                    ItemFilter(name: "Umum", onTap: () {}),
                                    ItemFilter(
                                        name: "Pertanyaanku", onTap: () {}),
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Divider(color: Colors.grey[300], thickness: 1),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white),
                                        ),
                                        child: const Text("Batalkan")),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  MyColors.primaryColorDark),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white),
                                        ),
                                        child: const Text("Terapkan"))
                                  ],
                                ),
                              ])),
                    )));
          });
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
                              child: TextField(
                                decoration: const InputDecoration(
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
                                onChanged: (value) {
                                  if (value.length > 2) {
                                    Future<List> result =
                                        Provider.of<CommunityNotifer>(context,
                                                listen: false)
                                            .searchingQuestion(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Filter Question
                          InkWell(
                            onTap: () => filterQuestion(value),
                            child: Container(
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
