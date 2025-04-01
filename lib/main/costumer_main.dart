import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/domain/provider/category_provider.dart';
import 'package:pizzaprint_v4/domain/provider/food_provider.dart';
import 'package:pizzaprint_v4/firebase_options.dart';
import 'package:pizzaprint_v4/interface/screen/customer/google_signup.dart';
import 'package:pizzaprint_v4/interface/screen/customer/home_screen.dart';
import 'package:pizzaprint_v4/interface/screen/customer/menu_screen.dart';
import 'package:pizzaprint_v4/interface/screen/customer/signup_screen.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => FoodProvider()), // Add FoodProvider
        ChangeNotifierProvider(create: (context) => CategoryProvider()), // Add CategoryProvider
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
      initialRoute: '/home', // Start from the Menu Screen
      routes: {
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const CreateAccount(),
        '/home': (context) => const HomeScreen(),
        '/menu': (context) => MenuScreen(),
      },
    );
  }
}

