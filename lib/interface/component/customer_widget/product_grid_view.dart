import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/product_card.dart';

class ProductGridView extends StatelessWidget {
  final List<Food> filteredProducts;
  final Function(Food) onProductTap;

  ProductGridView({required this.filteredProducts, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final food = filteredProducts[index];
        return GestureDetector(
          onTap: () => onProductTap(food),
          child: ProductCard(food: food),
        );
      },
    );
  }
}
