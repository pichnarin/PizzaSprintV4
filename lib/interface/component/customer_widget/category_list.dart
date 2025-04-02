import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart';

class CategoryListWidget extends StatelessWidget {
  final List<Category> categories;

  const CategoryListWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    );
  }
}


