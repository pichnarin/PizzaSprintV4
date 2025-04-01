import 'package:flutter/material.dart';
import 'delivery_custom_text_button.dart';

class EditProfileTextfield extends StatelessWidget {
  const EditProfileTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/user1.png'), // Replace with your image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add_circle, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),

              // Reusable Text Field
              _buildTextField('Your Name', 'Pizza Sprint'),
              const SizedBox(height: 20),
              _buildTextField('Your Email', 'pizzasprint@gmail.com'),
              const SizedBox(height: 20),
              _buildTextField('Phone number', '012 345 6789'),
              const SizedBox(height: 20),

              // Birthday Field (with suffix icon)
              const Text('Your Birthday'),
              TextFormField(
                initialValue: '20 - June - 1997',
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Save Button
              Center(
                child: CustomTextButton(
                  buttonText: 'Save',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Text Field Widget
  Widget _buildTextField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          initialValue: initialValue,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
          ),
        ),
      ],
    );
  }
}