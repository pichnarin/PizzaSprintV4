import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:pizzaprint_v4/env/environment.dart';

class OrderTrackingScreen extends StatefulWidget {
  final int orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  OrderTrackingScreenState createState() => OrderTrackingScreenState();
}

class OrderTrackingScreenState extends State<OrderTrackingScreen> {
  mp.MapboxMap? mapboxController;
  mp.PointAnnotationManager? annotationManager;
  mp.PolylineAnnotationManager? polylineManager;
  StreamSubscription? userPositionStream;

  @override
  void initState() {
    super.initState();
    _setupPositionTracking();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Order ${widget.orderId}')),
      body: mp.MapWidget(
        onMapCreated: _onMapCreated,
        styleUri: mp.MapboxStyles.SATELLITE_STREETS,
      ),
    );
  }

  void _onMapCreated(mp.MapboxMap controller) async {
    setState(() {
      mapboxController = controller;
    });

    // Enable user location tracking
    mapboxController?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    // Initialize annotation managers
    annotationManager = await mapboxController?.annotations.createPointAnnotationManager();
    polylineManager = await mapboxController?.annotations.createPolylineAnnotationManager();

    // Load marker images
    final Uint8List customerMarker = await loadMarkerImage("assets/images/user1.png");
    final Uint8List driverMarker = await loadMarkerImage("assets/images/delivery-guy.png");

    // Customer location (Phnom Penh, Cambodia)
    double customerLat = 11.5564;
    double customerLng = 104.9282;

    // Driver location (Nearby in Phnom Penh)
    double driverLat = 11.5600;
    double driverLng = 104.9350;

    // Add customer marker
    annotationManager?.create(
      mp.PointAnnotationOptions(
        image: customerMarker,
        iconSize: 0.3,
        geometry: mp.Point(
          coordinates: mp.Position(customerLng, customerLat),
        ),
      ),
    );

    // Add driver marker
    annotationManager?.create(
      mp.PointAnnotationOptions(
        image: driverMarker,
        iconSize: 0.3,
        geometry: mp.Point(
          coordinates: mp.Position(driverLng, driverLat),
        ),
      ),
    );

    // Draw route between customer and driver
    _drawRoute(mp.Position(customerLng, customerLat), mp.Position(driverLng, driverLat));
  }

  void _drawRoute(mp.Position start, mp.Position end) {
    polylineManager?.deleteAll(); // Clear old route

    polylineManager?.create(
      mp.PolylineAnnotationOptions(
        geometry: mp.LineString(
          coordinates: [
            start,
            end,
          ],
        ),
        lineWidth: 3.0,
        lineColor: Colors.blue.value,
      ),
    );
  }

  Future<void> _setupPositionTracking() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check location permissions
    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Setup location stream
    gl.LocationSettings locationSettings = gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();
    userPositionStream = gl.Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((gl.Position? position) {
      if (position != null && mapboxController != null) {
        print("Lat: ${position.latitude}, Lng: ${position.longitude}");

        // Update map camera with new position
        mapboxController?.setCamera(
          mp.CameraOptions(
            center: mp.Point(
              coordinates: mp.Position(position.longitude, position.latitude),
            ),
          ),
        );
      }
    });
  }

  Future<Uint8List> loadMarkerImage(String assetPath) async {
    var byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }
}
