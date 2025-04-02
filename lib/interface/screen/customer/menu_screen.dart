import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart' as CustomerCategories;
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/domain/provider/category_provider.dart';
import 'package:pizzaprint_v4/domain/provider/food_provider.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/category_tab_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/custom_app_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/product_grid_view.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/search_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/size_selection_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MenuScreen extends StatefulWidget {
  String? selectedLocation;

  MenuScreen({super.key, this.selectedLocation});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final int _selectedQuantity = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FoodProvider>(context, listen: false).fetchAllFoods();
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categoryProvider = Provider.of<CategoryProvider>(context);
    if (categoryProvider.categories.isNotEmpty && _tabController == null) {
      _tabController = TabController(
        length: categoryProvider.categories.length,
        vsync: this,
      );
    }
  }

  void _onSearch(String query) {
    Provider.of<FoodProvider>(context, listen: false).filterFoodsBySearch(query);
  }

  void _filterByCategory(Category category) {
    Provider.of<FoodProvider>(context, listen: false).getFoodByCategory(category.id);
  }

  void _navigateToSizeSelection(BuildContext context, Food food) async {
    final selectedSize = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SizeSelectionScreen(food: food),
      ),
    );

    if (!mounted || selectedSize == null) return;

    Provider.of<CartProvider>(context, listen: false).addToCart(
      food,
      selectedSize,
      _selectedQuantity,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Added ${food.name} ($selectedSize) to cart")),
    );
  }

  void _selectLocation() async {
    final selectedLocation = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context, 'Home');
              },
            ),
            ListTile(
              title: const Text('Office'),
              onTap: () {
                Navigator.pop(context, 'Office');
              },
            ),
            ListTile(
              title: const Text('Other'),
              onTap: () {
                Navigator.pop(context, 'Other');
              },
            ),
          ],
        );
      },
    );

    if (selectedLocation != null) {
      setState(() {
        widget.selectedLocation = selectedLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    if (foodProvider.isLoading || categoryProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (foodProvider.error.isNotEmpty || categoryProvider.error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(foodProvider.error.isNotEmpty
              ? foodProvider.error
              : categoryProvider.error),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Pizza Menu',
        selectedLocation: widget.selectedLocation,
        onLocationPressed: _selectLocation,
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onSearch: _onSearch,
          ),
          if (categoryProvider.categories.isNotEmpty)
            CategoryTabBar(
              tabController: _tabController,
              categories: categoryProvider.categories.cast<CustomerCategories.Category>(),
              onCategorySelected: _filterByCategory,
            ),
          ProductGridView(
            filteredProducts: foodProvider.filteredFoods,
            onProductTap: _navigateToSizeSelection,
          ),
        ],
      ),
    );
  }
}