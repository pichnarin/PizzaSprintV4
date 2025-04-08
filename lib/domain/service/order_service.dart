import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env/environment.dart';
import '../../env/user_local_storage/secure_storage.dart';
import '../model/orders.dart';
import 'api_service.dart';

class OrderService {
  Future<void> placeOrder(Map<String, dynamic> orderData) async {
    try {
      http.Response response = await apiService.post(
        "orders/place-orders",
        orderData,
      );

      if (response.statusCode == 201) {
        print("Order placed successfully: ${response.body}");
      } else {
        print("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  //driver fetching order
  Future<void> fetchOrderDetails() async {
    try {
      http.Response response = await apiService.get(
        "orders/driver-order-details",
      );
      if (response.statusCode == 200) {
        print("Order details fetched successfully: ${response.body}");
      } else {
        print("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  //fetch current order detail
  Future<List<Map<String, dynamic>>> fetchCurrentOrderDetail() async {
    try {
      http.Response response = await apiService.get(
        "orders/fetch-current-order-details",
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        
        print("Order details fetched successfully: ${response.body}");

        // Extract the list of orders safely
        List<dynamic> ordersData = responseData['data'] ?? [];

        // Map orders safely
        List<Map<String, dynamic>> orders =
            ordersData.map((order) {
              return {
                'orderId': order['id'],
                'orderNumber': order['order_number'] ?? 'N/A',
                'customerName': order['customer']?['name'] ?? 'Unknown',
                'customerEmail': order['customer']?['email'] ?? 'Unknown',
                'customerAvatar': order['customer']?['avatar'] ?? '',
                'customerPhone': order['customer']?['phone'] ?? 'N/A',
                'customerStatus': order['customer']?['status'] ?? 'N/A',
                'customerProvider': order['customer']?['provider'] ?? 'N/A',
                'customerProviderId':
                    order['customer']?['provider_id'] ?? 'N/A',
                'address': {
                  'reference': order['address']?['reference'] ?? 'N/A',
                  'city': order['address']?['city'] ?? 'N/A',
                  'state': order['address']?['state'] ?? 'N/A',
                  'zip': order['address']?['zip'] ?? 'N/A',
                  'longitude': order['address']?['longitude'] ?? 'N/A',
                  'latitude': order['address']?['latitude'] ?? 'N/A',
                },
                'orderItems':
                    (order['order_details'] as List<dynamic>?)
                        ?.map(
                          (item) => {
                            'itemName': item['name'] ?? 'Unknown',
                            'quantity': item['quantity'] ?? 0,
                            'price':
                                double.tryParse(item['price'] ?? '0.0') ?? 0.0,
                            'subTotal':
                                double.tryParse(item['sub_total'] ?? '0.0') ??
                                0.0,
                          },
                        )
                        .toList() ??
                    [],
                'status': order['status'] ?? 'Unknown',
                'assignedDriverId': order['driver_id'] ?? 'N/A',
                'totalAmount': double.tryParse(order['total'] ?? '0.0') ?? 0.0,
                'deliveryFee':
                    double.tryParse(order['delivery_fee'] ?? '0.0') ?? 0.0,
                'tax': double.tryParse(order['tax'] ?? '0.0') ?? 0.0,
                'discount': double.tryParse(order['discount'] ?? '0.0') ?? 0.0,
                'paymentMethod': order['payment_method'] ?? 'N/A',
                'estimatedDeliveryTime':
                    order['estimated_delivery_time'] ?? 'N/A',
                'notes': order['notes'] ?? 'N/A',
                'createdAt': order['created_at'] ?? 'N/A',
                'updatedAt': order['updated_at'] ?? 'N/A',
              };
            }).toList();

        return orders;
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  //fetch all accepted order
  Future<void> fetchAcceptedOrder() async {
    try {
      http.Response response = await apiService.get(
        "orders/fetch-accepeted-orders",
      );
      if (response.statusCode == 200) {
        print("Order details fetched successfully: ${response.body}");
      } else {
        print("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchAssigningOrders() async {
    try {
      http.Response response = await apiService.get(
        "orders/fetch-assigning-orders",
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract the list of orders safely
        List<dynamic> ordersData = responseData['data'] ?? [];

        // Map orders safely
        List<Map<String, dynamic>> orders =
            ordersData.map((order) {
              return {
                'orderId': order['id'],
                'orderNumber': order['order_number'] ?? 'N/A',
                'customerName': order['customer']?['name'] ?? 'Unknown',
                'customerEmail': order['customer']?['email'] ?? 'Unknown',
                'customerAvatar': order['customer']?['avatar'] ?? '',
                'customerPhone': order['customer']?['phone'] ?? 'N/A',
                'customerStatus': order['customer']?['status'] ?? 'N/A',
                'customerProvider': order['customer']?['provider'] ?? 'N/A',
                'customerProviderId':
                    order['customer']?['provider_id'] ?? 'N/A',
                'address': {
                  'reference': order['address']?['reference'] ?? 'N/A',
                  'city': order['address']?['city'] ?? 'N/A',
                  'state': order['address']?['state'] ?? 'N/A',
                  'zip': order['address']?['zip'] ?? 'N/A',
                  'longitude': order['address']?['longitude'] ?? 'N/A',
                  'latitude': order['address']?['latitude'] ?? 'N/A',
                },
                'orderItems':
                    (order['order_details'] as List<dynamic>?)
                        ?.map(
                          (item) => {
                            'itemName': item['name'] ?? 'Unknown',
                            'quantity': item['quantity'] ?? 0,
                            'price':
                                double.tryParse(item['price'] ?? '0.0') ?? 0.0,
                            'subTotal':
                                double.tryParse(item['sub_total'] ?? '0.0') ??
                                0.0,
                          },
                        )
                        .toList() ??
                    [],
                'status': order['status'] ?? 'Unknown',
                'assignedDriverId': order['driver_id'] ?? 'N/A',
                'totalAmount': double.tryParse(order['total'] ?? '0.0') ?? 0.0,
                'deliveryFee':
                    double.tryParse(order['delivery_fee'] ?? '0.0') ?? 0.0,
                'tax': double.tryParse(order['tax'] ?? '0.0') ?? 0.0,
                'discount': double.tryParse(order['discount'] ?? '0.0') ?? 0.0,
                'paymentMethod': order['payment_method'] ?? 'N/A',
                'estimatedDeliveryTime':
                    order['estimated_delivery_time'] ?? 'N/A',
                'notes': order['notes'] ?? 'N/A',
                'createdAt': order['created_at'] ?? 'N/A',
                'updatedAt': order['updated_at'] ?? 'N/A',
              };
            }).toList();

        return orders;
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }

  // Driver accepted order to delivering status
  Future<bool> acceptOrder(
    String orderId,
    double latitude,
    double longitude,
  ) async {
    try {
      String? token = await secureLocalStorage.retrieveToken();
      if (token == null) {
        print("No token found, user might need to log in.");
        return false;
      }

      print("Trying to accept order with ID: $orderId");

      final response = await http.put(
        Uri.parse(
          '${Environment.endpointApi}/orders/accept-delivering/$orderId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'status': 'delivering',
          'latitude': latitude,
          'longitude': longitude,
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print("Order status updated to 'delivering' with driver's location.");
        return true;
      } else {
        print(
          "Failed to update order status. Status Code: ${response.statusCode}",
        );
        print("Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error accepting order: $e");
      return false;
    }
  }

  //driver fetching order history
  Future<List<Map<String, dynamic>>?> fetchDeliveryOrderHistory() async {
    try {
      http.Response response = await apiService.get(
        "orders/fetch-delivering-order-history",
      );

      print("delivery order history response: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        var orders = responseData['data'];

        if (orders == null || orders.isEmpty) return [];

        List<Map<String, dynamic>> orderList = [];

        // Loop through the orders
        for (var order in orders) {
          final customer = order['customer'] ?? {};
          final address = order['address'] ?? {};
          final orderDetails = (order['order_details'] as List<dynamic>?) ?? [];

          orderList.add({
            'orderId': order['id'],
            'orderNumber': order['order_number'] ?? 'N/A',
            'customerName': customer['name'] ?? 'Unknown',
            'customerEmail': customer['email'] ?? 'Unknown',
            'customerAvatar': customer['avatar'] ?? '',
            'customerPhone': customer['phone'] ?? 'N/A',
            'customerStatus': customer['status'] ?? 'N/A',
            'customerProvider': customer['provider'] ?? 'N/A',
            'customerProviderId': customer['provider_id'] ?? 'N/A',
            'address': {
              'reference': address['reference'] ?? 'N/A',
              'city': address['city'] ?? 'N/A',
              'state': address['state'] ?? 'N/A',
              'zip': address['zip'] ?? 'N/A',
              'longitude': address['longitude'] ?? 'N/A',
              'latitude': address['latitude'] ?? 'N/A',
              'placeName': address['place_name'] ?? 'N/A',
            },
            'orderItems':
                orderDetails
                    .map(
                      (item) => {
                        'itemName': item['name'] ?? 'Unknown',
                        'quantity': item['quantity'] ?? 0,
                        'price':
                            double.tryParse(
                              item['price']?.toString() ?? '0.0',
                            ) ??
                            0.0,
                        'subTotal':
                            double.tryParse(
                              item['sub_total']?.toString() ?? '0.0',
                            ) ??
                            0.0,
                      },
                    )
                    .toList(),
            'status': order['status'] ?? 'Unknown',
            'assignedDriverId': order['driver_id'] ?? 'N/A',
            'totalAmount':
                double.tryParse(order['total']?.toString() ?? '0.0') ?? 0.0,
            'deliveryFee':
                double.tryParse(order['delivery_fee']?.toString() ?? '0.0') ??
                0.0,
            'tax': double.tryParse(order['tax']?.toString() ?? '0.0') ?? 0.0,
            'discount':
                double.tryParse(order['discount']?.toString() ?? '0.0') ?? 0.0,
            'paymentMethod': order['payment_method'] ?? 'N/A',
            'estimatedDeliveryTime': order['estimated_delivery_time'] ?? 'N/A',
            'notes': order['notes'] ?? 'N/A',
            'createdAt': order['created_at'] ?? 'N/A',
            'updatedAt': order['updated_at'] ?? 'N/A',
          });
        }

        return orderList;
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchOrderHistory() async {
    try {
      http.Response response = await apiService.get(
        "orders/fetch-completed-order-history",
      );

      print("order history response: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        var orders = responseData['data'];

        if (orders == null || orders.isEmpty) return [];

        List<Map<String, dynamic>> orderList = [];

        // Loop through the orders
        for (var order in orders) {
          final customer = order['customer'] ?? {};
          final address = order['address'] ?? {};
          final orderDetails = (order['order_details'] as List<dynamic>?) ?? [];

          orderList.add({
            'orderId': order['id'],
            'orderNumber': order['order_number'] ?? 'N/A',
            'customerName': customer['name'] ?? 'Unknown',
            'customerEmail': customer['email'] ?? 'Unknown',
            'customerAvatar': customer['avatar'] ?? '',
            'customerPhone': customer['phone'] ?? 'N/A',
            'customerStatus': customer['status'] ?? 'N/A',
            'customerProvider': customer['provider'] ?? 'N/A',
            'customerProviderId': customer['provider_id'] ?? 'N/A',
            'address': {
              'reference': address['reference'] ?? 'N/A',
              'city': address['city'] ?? 'N/A',
              'state': address['state'] ?? 'N/A',
              'zip': address['zip'] ?? 'N/A',
              'longitude': address['longitude'] ?? 'N/A',
              'latitude': address['latitude'] ?? 'N/A',
              'placeName': address['place_name'] ?? 'N/A',
            },
            'orderItems':
                orderDetails
                    .map(
                      (item) => {
                        'itemName': item['name'] ?? 'Unknown',
                        'quantity': item['quantity'] ?? 0,
                        'price':
                            double.tryParse(
                              item['price']?.toString() ?? '0.0',
                            ) ??
                            0.0,
                        'subTotal':
                            double.tryParse(
                              item['sub_total']?.toString() ?? '0.0',
                            ) ??
                            0.0,
                      },
                    )
                    .toList(),
            'status': order['status'] ?? 'Unknown',
            'assignedDriverId': order['driver_id'] ?? 'N/A',
            'totalAmount':
                double.tryParse(order['total']?.toString() ?? '0.0') ?? 0.0,
            'deliveryFee':
                double.tryParse(order['delivery_fee']?.toString() ?? '0.0') ??
                0.0,
            'tax': double.tryParse(order['tax']?.toString() ?? '0.0') ?? 0.0,
            'discount':
                double.tryParse(order['discount']?.toString() ?? '0.0') ?? 0.0,
            'paymentMethod': order['payment_method'] ?? 'N/A',
            'estimatedDeliveryTime': order['estimated_delivery_time'] ?? 'N/A',
            'notes': order['notes'] ?? 'N/A',
            'createdAt': order['created_at'] ?? 'N/A',
            'updatedAt': order['updated_at'] ?? 'N/A',
          });
        }

        return orderList;
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }


  // Driver accepted order to delivering status
  Future<bool> completeOrder(int orderId) async {
    try {
      String? token = await secureLocalStorage.retrieveToken();
      if (token == null) {
        print("No token found, user might need to log in.");
        return false;
      }

      print("Trying to accept order with ID: $orderId");

      final response = await http.put(
        Uri.parse(
          '${Environment.endpointApi}/orders/complete/$orderId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'status': 'completed',
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print("Order status updated to 'completed' with driver's location.");
        return true;
      } else {
        print(
          "Failed to update order status. Status Code: ${response.statusCode}",
        );
        print("Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error accepting order: $e");
      return false;
    }
  }


}
