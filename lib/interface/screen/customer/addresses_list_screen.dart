import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/screen/customer/create_location.dart';
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
    _fetchAddresses();
  }

  void _fetchAddresses() {
    setState(() {
      addresses = LocationService().fetchAllAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address or Create One'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapBoxScreen()),
                ).then((value) {
                  if (value != null) {
                    print('Returned value: $value');
                    _fetchAddresses(); // 🔄 Refresh address list after adding a new one
                  }
                });
              },
              icon: const Icon(Icons.add_location_alt_outlined),
            ),
          ),
        ],
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

          final addressList = snapshot.data ?? [];

          print("address list $addressList");

          if (addressList.isEmpty) {
            return const Center(child: Text('No saved addresses. Add one using the "+" button.'));
          }

          return ListView.builder(
            itemCount: addressList.length,
            itemBuilder: (context, index) {
              final address = addressList[index];
              return ListTile(
                title: Text(address.address.isNotEmpty ? address.address : 'Unnamed Address'),
                onTap: () {
                  if (address.id != null) {
                    Provider.of<AddressProvider>(
                      context,
                      listen: false,
                    ).addAddress(address.id!, address.address); // Force unwrap with `!`
                    Navigator.pop(context, address.id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Address ID is missing")),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
