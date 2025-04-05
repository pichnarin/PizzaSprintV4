// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
// import 'package:http/http.dart' as http;
// import 'package:pizzaprint_v4/env/environment.dart';
//
// class DriverMapScreen extends StatefulWidget {
//   final double customerLat;
//   final double customerLng;
//
//   DriverMapScreen({required this.customerLat, required this.customerLng});
//
//   @override
//   _DriverMapScreenState createState() => _DriverMapScreenState();
// }
//
// class _DriverMapScreenState extends State<DriverMapScreen> {
//   mp.MapboxMap? mapBoxController;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize any setup like user location tracking
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Route to Customer"),
//       ),
//       body: Stack(
//         children: [
//           // Map Display
//           mp.MapWidget(
//             onMapCreated: _onMapCreated,
//             styleUri: mp.StyleUri.light,
//             cameraOptions: mp.CameraOptions(
//               zoom: 12.0,
//               center: mp.Point(
//                 coordinates: mp.Position(widget.customerLng, widget.customerLat),
//               ),
//             ),
//           ),
//           // Show customer location as a marker
//           Positioned(
//             top: 100,
//             left: 20,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await _fetchRoute(
//                   40.7128, // Driver's lat (use actual location)
//                   -74.0060, // Driver's long (use actual location)
//                   widget.customerLat,
//                   widget.customerLng,
//                 );
//               },
//               child: Text("Get Route"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onMapCreated(mp.MapboxMap controller) {
//     setState(() {
//       mapBoxController = controller;
//     });
//     _addCustomerMarker();
//   }
//
//   Future<void> _fetchRoute(double startLat, double startLng, double endLat, double endLng) async {
//     final url = Uri.parse(
//         "https://api.mapbox.com/directions/v5/mapbox/driving/$startLng,$startLat;$endLng,$endLat?geometries=geojson&access_token=${Environment.mapboxApiKey}"
//     );
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final route = data['routes'][0]['geometry']['coordinates'];
//
//       // Draw the route on the map
//       _drawRoute(route);
//     } else {
//       print("Failed to fetch route: ${response.body}");
//     }
//   }
//
//   void _drawRoute(List<dynamic> coordinates) {
//     if (mapBoxController != null) {
//       List<mp.LatLng> routeCoordinates = coordinates.map((coord) {
//         return mp.LatLng(coord[1], coord[0]);
//       }).toList();
//
//       // Add line to represent the route
//       mapBoxController?.addLine(
//         mp.LineOptions(
//           geometry: routeCoordinates,
//           lineColor: mp.Color.fromARGB(255, 0, 0, 255),
//           lineWidth: 5.0,
//         ),
//       );
//
//       // Adjust the camera to focus on the route
//       mapBoxController?.setCamera(
//         mp.CameraOptions(
//           center: mp.Point(coordinates: mp.Position(routeCoordinates[0].longitude, routeCoordinates[0].latitude)),
//           zoom: 14.0,
//         ),
//       );
//     }
//   }
//
//   void _addCustomerMarker() {
//     if (mapBoxController != null) {
//       // Add customer location marker to map
//       mapBoxController?.addSymbol(
//         mp.SymbolOptions(
//           geometry: mp.LatLng(widget.customerLat, widget.customerLng),
//           iconImage: "assets/customer_marker.png", // Use an appropriate icon
//           iconSize: 1.0,
//         ),
//       );
//     }
//   }
// }
