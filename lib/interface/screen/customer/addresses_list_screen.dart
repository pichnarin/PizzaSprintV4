import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/addresses.dart';
import '../../../domain/provider/address_provider.dart';
import '../../../domain/service/location_service.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  AddressListScreenState createState() => AddressListScreenState();
}

class AddressListScreenState extends State<AddressListScreen> {
  late Future<List<Addresses>> addresses;

  @override
  void initState() {
    super.initState();
    addresses = LocationService().fetchAllAddress(); // Fetching addresses
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: FutureBuilder<List<Addresses>>(
        future: addresses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final addressList = snapshot.data!;

          return ListView.builder(
            itemCount: addressList.length,
            itemBuilder: (context, index) {
              final address = addressList[index];
              return ListTile(
                title: Text(address.address), // Show address details
                onTap: () {
                  // Add selected address to provider and pop it back
                  Provider.of<AddressProvider>(context, listen: false)
                      .addAddress(address.id, address.address);
                  Navigator.pop(context, address.id); // Return address ID
                },
              );
            },
          );
        },
      ),
    );
  }
}
