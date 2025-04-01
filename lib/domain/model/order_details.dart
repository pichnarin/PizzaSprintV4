class OrderDetail{
  int id;
  String name;
  int quantity;
  double price;
  double sub_total;

  int foodId;
  int orderId;

  OrderDetail({required this.id, required this.name, required this.quantity, required this.price, required this.sub_total, required this.foodId, required this.orderId});

  factory OrderDetail.fromJson(Map<String, dynamic> json){
    return OrderDetail(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      sub_total: json['sub_total'],
      foodId: json['food_id'],
      orderId: json['order_id'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'sub_total': sub_total,
      'food_id': foodId,
      'order_id': orderId,
    };
  }
}