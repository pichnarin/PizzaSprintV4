import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/provider/user_provider.dart';
import 'package:pizzaprint_v4/interface/screen/delivery/welcome_screen.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';
import 'package:provider/provider.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: WelcomeScreen(),
        )
    );
  }
}



