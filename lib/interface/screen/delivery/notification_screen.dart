import 'package:flutter/material.dart';

import '../../component/driver_widget/delivery_custom_icon_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          CustomIconButton(
            icon: Icons.check_circle,
            text: 'Restaurant/ System\nBooking #1234 has been succcess....',
            onTap: () {},
            iconBackgroundColor: Colors.blue,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.card_giftcard,
            text: 'Promotion\nInvite friends - Get 3 coupons each!',
            onTap: () {},
            iconBackgroundColor: Colors.yellow,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.card_giftcard,
            text: 'Promotion\nInvite friends - Get 3 coupons each!',
            onTap: () {},
            iconBackgroundColor: Colors.yellow,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.cancel,
            text: 'Restaurant/ System\nBooking #1231 has been cancelled',
            onTap: () {},
            iconBackgroundColor: Colors.red,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.receipt,
            text: 'Restaurant/ System\nThank you! Your transaction is completed...',
            onTap: () {},
            iconBackgroundColor: Colors.lightGreen,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.check_circle,
            text: 'Restaurant/ System\nBooking #1233 has been succcess....',
            onTap: () {},
            iconBackgroundColor: Colors.blue,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.card_giftcard,
            text: 'Promotion\nInvite friends - Get 3 coupons each!',
            onTap: () {},
            iconBackgroundColor: Colors.yellow,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.check_circle,
            text: 'Restaurant/ System\nBooking #1234 has been succcess....',
            onTap: () {},
            iconBackgroundColor: Colors.blue,
          ),
          const Divider(),
          CustomIconButton(
            icon: Icons.check_circle,
            text: 'Restaurant/ System\nBooking #1234 has been succcess....',
            onTap: () {},
            iconBackgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
