enum OrderStatus {
  pending,
  accepted,
  cooking,
  on_the_way,
  completed,
  declined,
  canceled
}

enum PaymentMethod {
  aba,
  paid_out,
  un_paid,
}

class Order {
  int id;
  String orderNumber;
  int customerId;
  int? driverId;
  int addressId;

  String orderStatus;
  String paymentMethod;
  int quantity;
  double total;
  double? deliveryFee;
  double? tax;
  double? discount;
  DateTime? estimatedDeliveryTime;
  String? note;

  Order({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    this.driverId,
    required this.addressId,
    required this.orderStatus,
    required this.paymentMethod,
    required this.quantity,
    required this.total,
    this.deliveryFee,
    this.tax,
    this.discount,
    this.estimatedDeliveryTime,
    this.note,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      customerId: json['customer_id'],
      driverId: json['driver_id'],
      addressId: json['address_id'],
      orderStatus: json['order_status'],
      paymentMethod: json['payment_method'],
      quantity: json['quantity'],
      total: json['total'],
      deliveryFee: json['delivery_fee'],
      tax: json['tax'],
      discount: json['discount'],
      estimatedDeliveryTime: json['estimated_delivery_time'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'customer_id': customerId,
      'driver_id': driverId,
      'address_id': addressId,
      'order_status': orderStatus,
      'payment_method': paymentMethod,
      'quantity': quantity,
      'total': total,
      'delivery_fee': deliveryFee,
      'tax': tax,
      'discount': discount,
      'estimated_delivery_time': estimatedDeliveryTime,
      'note': note,
    };
  }
}
