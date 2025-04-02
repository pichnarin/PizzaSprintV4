import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/domain/provider/category_provider.dart';
import 'package:pizzaprint_v4/domain/provider/food_provider.dart';
import 'package:pizzaprint_v4/firebase_options.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/buttom_nav_bar.dart';
import 'package:pizzaprint_v4/interface/screen/customer/google_signup.dart';
import 'package:pizzaprint_v4/interface/screen/customer/signup_screen.dart';
import 'package:pizzaprint_v4/interface/screen/customer/home_screen.dart';
import 'package:provider/provider.dart';

import '../domain/provider/address_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (!e.toString().contains('A Firebase App named "[DEFAULT]" already exists')) {
      debugPrint("Firebase Initialization Error: $e");
    }
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FoodProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Start with HomeScreen
      routes: {
        '/menu': (context) => const BottomNavBar(), // Add route for MainWrapper
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const CreateAccount(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}