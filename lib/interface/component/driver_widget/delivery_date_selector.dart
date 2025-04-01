import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';


class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final int daysCount = 30; // Generate 30 days
  int selectedIndex = 0; // Default: First day selected

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date Selector (Scrollable)
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: daysCount,
            itemBuilder: (context, index) {
              DateTime date = DateTime.now().add(Duration(days: index));
              String dayName = DateFormat('E').format(date); // Mon, Tue, Wed, etc.
              String dayNumber = DateFormat('d').format(date); // 1, 2, 3, ..., 30
              
              bool isSelected = index == selectedIndex; // Check if selected

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index; // Update selected date
                  });
                },
                child: Container(
                  width: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? AppPallete.dateColor : AppPallete.dateContainer, // Highlight selected
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: isSelected ? AppPallete.button : Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayName, 
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppPallete.dateColor, // Change text color
                        ),
                      ),
                      Text(
                        dayNumber, 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppPallete.dateColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),   
      ],
    );
  }

}