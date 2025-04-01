import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';
import '../../../domain/provider/user_provider.dart';
import '../../component/driver_widget/delivery_custom_text_button.dart';
import '../../component/driver_widget/delivery_fill_in_profile_textfield.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserProvider userProvider = UserProvider();

  bool isLoading = false;
  String? errorMessage;

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Please enter both email and password";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    bool isLoginSuccessful = await userProvider.login(email, password);

    setState(() {
      isLoading = false;
    });

    if (isLoginSuccessful) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to a home screen or dashboard
      );
    } else {
      setState(() {
        errorMessage = userProvider.errorMessage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Login to your\nAccount',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 30),
                ReusableTextField(
                  controller: _emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                ReusableTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 50),  
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                  child: Column(
                    children: [
                      CustomTextButton(
                        buttonText: 'Sign in', 
                        onPressed: login,
                      ),
                      if (errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: (){
                        },
                        child: const Text(
                          'Forgot the password?',
                          style: TextStyle(
                            color: AppPallete.signInUpText, 
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 30),       
              ]
              
            ),
          ),
        ),
    );
    
  }
}

