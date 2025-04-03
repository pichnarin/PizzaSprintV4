class Addresses {
  int? id; // Optional because it is auto-generated
  double latitude;
  double longitude;
  String? reference;
  String? city;
  String? state;
  String? zip;

  Addresses({
    this.id, // ID is optional
    required this.latitude,
    required this.longitude,
    this.reference,
    this.city,
    this.state,
    this.zip,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null, // Parsing ID if present
      latitude: json['latitude'] is double
          ? json['latitude']
          : double.parse(json['latitude'].toString()),
      longitude: json['longitude'] is double
          ? json['longitude']
          : double.parse(json['longitude'].toString()),
      reference: json['reference'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
    );
  }

  /// Return a formatted address, ensuring null safety
  String get address =>
      '${city ?? ''}, ${state ?? ''}, ${zip ?? ''}'.trim().replaceAll(RegExp(r',\s+,'), ',');

  // Convert the model to a map for sending to API or saving
  Map<String, dynamic> toJson() {
    final data = {
      'latitude': latitude,
      'longitude': longitude,
      'reference': reference,
      'city': city,
      'state': state,
      'zip': zip,
    };
    if (id != null) data['id'] = id; // Only include the ID if it's not null
    return data;
  }
}
