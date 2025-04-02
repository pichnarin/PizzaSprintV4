import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/domain/provider/food_provider.dart';
import 'package:pizzaprint_v4/domain/service/category_service.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/custom_app_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/product_grid_view.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/search_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/size_selection_screen.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  String? selectedLocation;

  MenuScreen({super.key, this.selectedLocation});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  final int _selectedQuantity = 1;
  Category? _selectedCategory;
  final CategoryService _categoryService = CategoryService();
  bool _isLoading = false;
  String _error = '';
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FoodProvider>(context, listen: false).fetchAllFoods();
      _fetchCategories();
    });
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final fetchedCategories = await _categoryService.fetchCategories();
      // Add the "All" category at the beginning of the list
      setState(() {
        _categories = [Category(id: 0, name: 'All')] + fetchedCategories;
      });
    } catch (e) {
      setState(() {
        _error = 'Error fetching categories: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearch(String query) {
    Provider.of<FoodProvider>(context, listen: false).filterFoodsBySearch(query);
  }

  void _navigateToSizeSelection(BuildContext context, Food food) async {
    final selectedSize = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SizeSelectionScreen(food: food)),
    );

    if (!mounted || selectedSize == null) return;

    Provider.of<CartProvider>(context, listen: false).addToCart(food, selectedSize, _selectedQuantity);

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
              onTap: () => Navigator.pop(context, 'Home'),
            ),
            ListTile(
              title: const Text('Office'),
              onTap: () => Navigator.pop(context, 'Office'),
            ),
            ListTile(
              title: const Text('Other'),
              onTap: () => Navigator.pop(context, 'Other'),
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Pizza Menu',
        selectedLocation: widget.selectedLocation,
        onLocationPressed: _selectLocation,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(controller: _searchController, onSearch: _onSearch),
            const SizedBox(height: 10),

            /// Categories Section
            Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _error.isNotEmpty
                  ? Center(child: Text(_error, style: TextStyle(color: Colors.red)))
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory?.id == category.id;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (category.name == 'All') {
                          // Show all foods when "All" is selected
                          _selectedCategory = null;
                          Provider.of<FoodProvider>(context, listen: false).fetchAllFoods();
                        } else {
                          if (_selectedCategory?.id == category.id) {
                            _selectedCategory = null;
                            Provider.of<FoodProvider>(context, listen: false).fetchAllFoods();
                          } else {
                            _selectedCategory = category;
                            Provider.of<FoodProvider>(context, listen: false).getFoodByCategory(category.name);
                          }
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            /// Foods Section
            Text(
              "Available Foods",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: foodProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : foodProvider.error.isNotEmpty
                  ? Center(child: Text(foodProvider.error, style: TextStyle(color: Colors.red)))
                  : ProductGridView(
                filteredProducts: foodProvider.filteredFoods,
                onProductTap: _navigateToSizeSelection,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
