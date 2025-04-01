import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:pizzaprint_v4/env/environment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupMapbox();
  runApp(MyApp());
}

void setupMapbox() {
  const String mapboxAccessToken = Environment.mapboxApiKey; // Replace with your actual token
  MapboxOptions.setAccessToken(mapboxAccessToken);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapBoxScreen(),
    );
  }
}

class MapBoxScreen extends StatefulWidget {
  const MapBoxScreen({super.key});

  @override
  State<MapBoxScreen> createState() => _MapBoxScreenState();
}

class _MapBoxScreenState extends State<MapBoxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(),
    );
  }
}
