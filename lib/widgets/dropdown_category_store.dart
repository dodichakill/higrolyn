import 'package:agrolyn/providers/community_notifer.dart';
import 'package:agrolyn/providers/store_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownCategoryStore extends StatefulWidget {
  const DropdownCategoryStore({super.key});

  @override
  _DropdownCategoryState createState() => _DropdownCategoryState();
}

class _DropdownCategoryState extends State<DropdownCategoryStore> {
  String _selectedCategory = 'Mentah';
  final List<String> _categories = ['Mentah', 'Olahan', 'Lainnya'];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreNotifier(context: context),
      child: Consumer<StoreNotifier>(
          builder: (context, value, child) => DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    value.selectCategoryProduct(newValue);
                  });
                },
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              )),
    );
  }
}
