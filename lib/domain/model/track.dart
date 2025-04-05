class DriverTracking{
  int id;
  double lat;
  double long;
  int orderId;
  int driverId;
  int addressId;

  DriverTracking({
    required this.id,
    required this.lat,
    required this.long,
    required this.orderId,
    required this.driverId,
    required this.addressId,
  });

  factory DriverTracking.fromJson(Map<String, dynamic> json) {
    return DriverTracking(
      id: json['id'],
      lat: json['latitude'],
      long: json['longitude'],
      orderId: json['order_id'],
      driverId: json['driver_id'],
      addressId: json['address_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'long': long,
      'order_id': orderId,
      'driver_id': driverId,
      'address_id': addressId,
    };
  }
}