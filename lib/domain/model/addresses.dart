class Addresses {
  int id;
  double latitude;
  double longitude;
  String? reference;
  String? city;
  String? street;
  String? state;
  String? zip;

  Addresses({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.reference,
    this.city,
    this.street,
    this.state,
    this.zip,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      latitude: json['latitude'] is double
          ? json['latitude']
          : double.parse(json['latitude'].toString()),
      longitude: json['longitude'] is double
          ? json['longitude']
          : double.parse(json['longitude'].toString()),
      reference: json['reference'],
      city: json['city'],
      street: json['street'],
      state: json['state'],
      zip: json['zip'],
    );
  }

  String get address => '$street, $city, $state, $zip';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'reference': reference,
      'city': city,
      'street': street,
      'state': state,
      'zip': zip,
    };
  }
}
