import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:pizzaprint_v4/domain/service/track_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  late IO.Socket socket;
  TrackService trackService = TrackService();
  mp.Position? customerPosition;
  mp.PointAnnotation? driverAnnotation;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _setupPositionTracking();
    _fetchDriverLocation();
    _initializeSocket();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Order ${widget.orderId}')),
      body: Stack(
        children: [
          mp.MapWidget(
            onMapCreated: _onMapCreated,
            styleUri: mp.MapboxStyles.SATELLITE_STREETS,
          ),
          if (isLoading) Center(child: CircularProgressIndicator()),
          if (errorMessage != null)
            Center(
              child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }

  void _onMapCreated(mp.MapboxMap controller) async {
    setState(() {
      mapboxController = controller;
    });

    mapboxController?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    annotationManager =
        await mapboxController?.annotations.createPointAnnotationManager();
    polylineManager =
        await mapboxController?.annotations.createPolylineAnnotationManager();
  }

  void _drawRoute(mp.Position start, mp.Position end) {
    polylineManager?.deleteAll();

    polylineManager?.create(
      mp.PolylineAnnotationOptions(
        geometry: mp.LineString(coordinates: [start, end]),
        lineWidth: 5.0,
        lineColor: Colors.green.value,
      ),
    );
  }

  Future<void> _setupPositionTracking() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        errorMessage = 'Location services are disabled.';
      });
      return;
    }

    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        setState(() {
          errorMessage = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      setState(() {
        errorMessage =
            'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

    gl.LocationSettings locationSettings = gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 500,
    );

    userPositionStream?.cancel();
    userPositionStream = gl.Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((gl.Position? position) {
      if (position != null && mapboxController != null) {
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

  Future<void> _fetchDriverLocation() async {
    try {
      final response = await trackService.fetchCustomerDriverLocation(
        widget.orderId,
      );

      final driverLocation = response['driver_location'];
      final customerLocation = response['customer_location'];

      double driverLat = double.parse(driverLocation['latitude'].toString());
      double driverLng = double.parse(driverLocation['longitude'].toString());
      double customerLat = double.parse(
        customerLocation['latitude'].toString(),
      );
      double customerLng = double.parse(
        customerLocation['longitude'].toString(),
      );

      customerPosition = mp.Position(customerLng, customerLat);

      final Uint8List driverMarker = await loadMarkerImage(
        "assets/images/delivery-guy.png",
      );
      final Uint8List customerMarker = await loadMarkerImage(
        "assets/images/user1.png",
      );

      annotationManager?.deleteAll();

      driverAnnotation = await annotationManager?.create(
        mp.PointAnnotationOptions(
          image: driverMarker,
          iconSize: 0.3,
          geometry: mp.Point(coordinates: mp.Position(driverLng, driverLat)),
        ),
      );

      annotationManager?.create(
        mp.PointAnnotationOptions(
          image: customerMarker,
          iconSize: 0.3,
          geometry: mp.Point(
            coordinates: mp.Position(customerLng, customerLat),
          ),
        ),
      );

      if (customerPosition != null) {
        _drawRoute(customerPosition!, mp.Position(driverLng, driverLat));
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching driver location: $e';
        isLoading = false;
      });
    }
  }

  void _initializeSocket() {
    socket = IO.io('http://192.168.1.10:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to socket!');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket!');
    });

    socket.onConnectError((err) {
      print('Connection error: $err');
    });

    socket.on('driver-location', (data) async {
      print('Real-time driver location: $data');

      double? driverLat =
          data['driver_lat'] != null
              ? double.tryParse(data['driver_lat'].toString())
              : null;
      double? driverLng =
          data['driver_long'] != null
              ? double.tryParse(data['driver_long'].toString())
              : null;

      if (driverLat == null ||
          driverLng == null ||
          driverLat.isNaN ||
          driverLng.isNaN) {
        print('Invalid driver location data');
        return;
      }

      if (driverAnnotation != null) {
        await annotationManager?.delete(driverAnnotation!);
      }

      driverAnnotation = await annotationManager?.create(
        mp.PointAnnotationOptions(
          image: await loadMarkerImage("assets/images/delivery-guy.png"),
          iconSize: 0.3,
          geometry: mp.Point(coordinates: mp.Position(driverLng, driverLat)),
        ),
      );

      if (customerPosition != null) {
        _drawRoute(customerPosition!, mp.Position(driverLng, driverLat));
      }
    });
  }

  Future<Uint8List> loadMarkerImage(String assetPath) async {
    var byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }
}
