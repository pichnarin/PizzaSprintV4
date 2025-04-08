import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverLocationTracker {
  late IO.Socket socket;

  DriverLocationTracker() {
    // Connect to the Node.js server
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
    });

    // Listen for location updates from the server
    socket.on('driver-location', (data) {
      // Handle the updated location data
      print('Driver Location Updated: $data');
      // Update the map or UI based on the new location data
      // For example, you can use Google Maps or Mapbox to update the driver's position
    });
  }

  void close() {
    socket.disconnect();
  }
}
