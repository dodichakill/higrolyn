import 'package:flutter/material.dart';

class SearchCategoryStore extends StatefulWidget {
  const SearchCategoryStore({super.key});

  @override
  State<SearchCategoryStore> createState() => _SearchCategoryStoreState();
}

class _SearchCategoryStoreState extends State<SearchCategoryStore> {
  final List<String> categories = [
    'Kategori: Semua',
    'Kategori: Mentah',
    'Kategori: Olahan',
    'Kategori: Lainnya'
  ];

  String selectedCategory = 'Semua';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TextField untuk pencarian
        Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Cari Produk di sini',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),

        // DropdownButton untuk kategori
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton<String>(
            value: selectedCategory,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            underline: const SizedBox(),
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(
                  category,
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}
