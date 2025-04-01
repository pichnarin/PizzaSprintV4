import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart' as CustomerCategories;
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/domain/provider/category_provider.dart';
import 'package:pizzaprint_v4/domain/provider/food_provider.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/app_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/category_tab_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/convex_bottom_nav.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/product_grid_view.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/search_bar.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/size_selection_screen.dart';
import 'package:pizzaprint_v4/interface/screen/customer/cart_screen.dart';
import 'package:pizzaprint_v4/interface/screen/customer/profile_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MenuScreen extends StatefulWidget {
  String? selectedLocation;

  MenuScreen({super.key, this.selectedLocation});

  @override
  // ignore: library_private_types_in_public_api
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  // int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final int _selectedQuantity = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Fetch foods and categories when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FoodProvider>(context, listen: false).fetchAllFoods();
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categoryProvider = Provider.of<CategoryProvider>(context);
    // ignore: unnecessary_null_comparison
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate to Cart screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    } else if (index == 2) {
      // Navigate to Profile screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfileScreen()),
      );
    }
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

    // Show loading indicator if data is still loading
    if (foodProvider.isLoading || categoryProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show error message if there was an error
    if (foodProvider.error.isNotEmpty || categoryProvider.error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(foodProvider.error.isNotEmpty 
              ? foodProvider.error 
              : categoryProvider.error),
        ),
      );
    }

    // Initialize tab controller if it's not already initialized
    // ignore: unnecessary_null_comparison
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  final categoryProvider = Provider.of<CategoryProvider>(context);

  if (_tabController.length != categoryProvider.categories.length) {
    _tabController.dispose();
    _tabController = TabController(
      length: categoryProvider.categories.length,
      vsync: this,
    );
  }
}


    return Scaffold(
      backgroundColor: Colors.white, 
      // appBar: AppBar(
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Pizza Menu',
      //         style: PizzaTextStyles.heading.copyWith(
      //           color: PizzaColors.white,
      //         ),
      //       ),
      //       if (widget.selectedLocation != null)
      //         Text(
      //           'Delivery to: ${widget.selectedLocation}',
      //           style: PizzaTextStyles.body.copyWith(
      //             // ignore: deprecated_member_use
      //             color: PizzaColors.white.withOpacity(0.7),
      //           ),
      //         ),
      //     ],
      //   ),
      //   backgroundColor: PizzaColors.primary,
      //   foregroundColor: PizzaColors.white,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.location_on),
      //       onPressed: _selectLocation,
      //     ),
      //   ],
      // ),
       appBar: CustomAppBar(  // Call the custom AppBar
        title: 'Pizza Menu',  // Title for the AppBar
        selectedLocation: widget.selectedLocation,  // Pass location if available
        onLocationPressed: _selectLocation,  // Function to handle location button press
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
 
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: PizzaColors.primary,
      //   unselectedItemColor: PizzaColors.neutralLight,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.local_pizza),
      //       label: "Menu",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag),
      //       label: "Cart",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: "Profile",
      //     ),
      //   ],
      // ),

       bottomNavigationBar: ReactStyleConvexAppBar(
        onItemTapped: _onItemTapped, // Pass the function to handle navigation
      ),
    );
  }
}
