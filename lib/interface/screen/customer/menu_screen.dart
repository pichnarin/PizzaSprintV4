import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/domain/provider/food_provider.dart';
import 'package:pizzaprint_v4/domain/service/category_service.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/product_grid_view.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/search_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/size_selection_screen.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  final int _selectedQuantity = 1;
  final CategoryService _categoryService = CategoryService();
  bool _isLoading = false;
  bool _showSearchBar = false;
  String _error = '';
  List<Category> _categories = [];
  Category? _selectedCategory;

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
    Provider.of<FoodProvider>(
      context,
      listen: false,
    ).filterFoodsBySearch(query);
  }

  void _navigateToSizeSelection(BuildContext context, Food food) async {
    final selectedSize = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SizeSelectionScreen(food: food)),
    );

    if (!mounted || selectedSize == null) return;

    Provider.of<CartProvider>(
      context,
      listen: false,
    ).addToCart(food, selectedSize, _selectedQuantity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Added ${food.name} ($selectedSize) to cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pizza Menu'),
        actions: [
          IconButton(
            icon: Icon(_showSearchBar ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showSearchBar)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SearchBarWidget(
                  controller: _searchController,
                  onSearch: _onSearch,
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              height: 32,
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _error.isNotEmpty
                      ? Center(
                        child: Text(
                          _error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                      : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected =
                              _selectedCategory?.id == category.id;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (category.name == 'All') {
                                  _selectedCategory = null;
                                  foodProvider.fetchAllFoods();
                                } else if (_selectedCategory?.id ==
                                    category.id) {
                                  _selectedCategory = null;
                                  foodProvider.fetchAllFoods();
                                } else {
                                  _selectedCategory = category;
                                  foodProvider.getFoodByCategory(category.name);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.orange
                                        : Colors.grey[200],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child:
                  foodProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : foodProvider.error.isNotEmpty
                      ? Center(
                        child: Text(
                          foodProvider.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                      : ProductGridView(
                        filteredProducts: foodProvider.filteredFoods,
                        onProductTap:
                            (food) => _navigateToSizeSelection(context, food),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
