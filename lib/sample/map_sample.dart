import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

import '../domain/model/addresses.dart';
import '../domain/service/location_service.dart';


class MapBoxScreen extends StatefulWidget {
  const MapBoxScreen({super.key});

  @override
  State<MapBoxScreen> createState() => _MapBoxScreenState();
}

class _MapBoxScreenState extends State<MapBoxScreen> {
  mp.MapboxMap? mapBoxController;
  StreamSubscription? positionSubscription;

  final LocationService _locationService = LocationService();
  String _address = '';
  Map<String, dynamic>? _currentAddressData;

  Future<void> _fetchAddress(double latitude, double longitude) async {
    try {
      final result = await _locationService.fetchAddressByCoordinate(latitude, longitude);
      if (result != null) {
        setState(() {
          _currentAddressData = result;
          _address = "${result['reference']}, ${result['city']}, ${result['state']}";
        });

        // Ask user if they want to set this as the delivery location
        _showAddressConfirmationDialog(result);
      }
    } catch (e) {
      setState(() {
        _address = 'Error: $e';
      });
    }
  }

  void _showAddressConfirmationDialog(Map<String, dynamic> addressData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Delivery Location"),
        content: Text("Would you like to set '${addressData['reference']}, ${addressData['city']}' as your delivery location?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("No")
          ),
          TextButton(
              onPressed: () {
                _saveAddress(addressData);
                Navigator.pop(context);
              },
              child: Text("Yes")
          ),
        ],
      ),
    );
  }

  Future<void> _saveAddress(Map<String, dynamic> addressData) async {
    Addresses newAddress = Addresses(
      latitude: addressData["latitude"],
      longitude: addressData["longitude"],
      city: addressData["city"] ?? "",
      state: addressData["state"] ?? "",
      zip: addressData["zip"] ?? "",
      reference: addressData["reference"] ?? "",
    );

    try {
      await _locationService.createAddress(newAddress);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Address saved successfully!"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save address: $e"))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _setupPositionTracking();
  }

  @override
  void dispose() {
    positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          mp.MapWidget(onMapCreated: _onMapCreated),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 5),
                ],
              ),
              child: Text(
                _address,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(mp.MapboxMap controller) {
    setState(() {
      mapBoxController = controller;
    });

    mapBoxController?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
  }

  Future<void> _setupPositionTracking() async {
    bool isServiceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    geo.LocationSettings locationSettings = geo.LocationSettings(
      accuracy: geo.LocationAccuracy.high,
      distanceFilter: 10, // Updates when moving 10m
    );

    positionSubscription?.cancel();
    positionSubscription = geo.Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((geo.Position? position) {
      if (position != null) {
        print("Lat: ${position.latitude}, Lng: ${position.longitude}");

        // Fetch the address for the new location
        _fetchAddress(position.latitude, position.longitude);

        // Update Mapbox camera to follow user's location
        mapBoxController?.setCamera(
          mp.CameraOptions(
            center: mp.Point(
              coordinates: mp.Position(position.longitude, position.latitude),
            ),
            zoom: 15.0,
          ),
        );
      }
    });
  }
}
