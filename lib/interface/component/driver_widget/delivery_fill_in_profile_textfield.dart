import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';

class ReusableTextField extends StatefulWidget {
  const ReusableTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap, // handle tap events for DatePicker
    this.suffixIcon, 
  });

  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap; // Callback for when the field is tapped (e.g., date picker)
  final Widget? suffixIcon; 

  @override
  _ReusableTextFieldState createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  late bool _secureText;

  @override
  void initState() {
    super.initState();
    _secureText = widget.obscureText; // Initialize with provided obscureText value
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _secureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          
          hintText: widget.hintText,
          fillColor: AppPallete.fillText,
          filled: true,
          suffixIcon: widget.suffixIcon ??
              (widget.obscureText // Only show the toggle if it's a password field
              ? IconButton(
                  icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _secureText = !_secureText; // Toggle visibility
                    });
                  },
                )
              : null),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
