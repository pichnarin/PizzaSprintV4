import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/interface/theme/theme.dart';

class CategoryTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Category> categories; // Updated to use Category model
  final Function(Category) onCategorySelected; // Updated to pass Category object

  const CategoryTabBar({
    super.key,
    required this.tabController,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center( // Center the TabBar
        child: TabBar(
          controller: tabController,
          isScrollable: false, // Remove this property to evenly space the tabs
          indicatorColor: PizzaColors.secondary,
          indicatorSize: TabBarIndicatorSize.label, // Make indicator match tab width
          labelStyle: PizzaTextStyles.heading.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          unselectedLabelStyle: PizzaTextStyles.body.copyWith(
            fontSize: 14,
          ),
          tabs: categories
              .map(
                (category) => Tab(
                  text: category.name, // Use category.name instead of category
                ),
              )
              .toList(),
          onTap: (index) {
            onCategorySelected(categories[index]); // Pass the Category object
          },
        ),
      ),
    );
  }
}

