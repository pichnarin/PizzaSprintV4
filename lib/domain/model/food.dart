class Food {
  int id;
  String name;
  String description;
  double price;
  String image;

  Food({required this.id, required this.name, required this.description, required this.price, required this.image});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: _parsePrice(json['price']), // Ensure the price is parsed correctly
      image: json['image'],
    );
  }

  static double _parsePrice(dynamic price) {
    if (price is String) {
      // Handle the case where price is a string (e.g., "12.34")
      return double.tryParse(price) ?? 0.0; // If the parsing fails, return a default value (0.0)
    }
    return price.toDouble(); // If it's already a number (double or int), convert it
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
