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
    return Consumer<StoreNotifier>(
        builder: (context, value, child) => Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                        value.selectCategoryProduct(newValue);
                      });
                    },
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ));
  }
}
