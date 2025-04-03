import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env/environment.dart';
import '../../env/user_local_storage/secure_storage.dart';
import 'api_service.dart';

class OrderService {
  Future<void> placeOrder(Map<String, dynamic> orderData) async {
    try {
      http.Response response =
      await apiService.post("orders/place-orders", orderData);

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
      http.Response response =
      await apiService.get("orders/driver-order-details");
      if (response.statusCode == 200) {
        print("Order details fetched successfully: ${response.body}");
      } else {
        print("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  //fetch all accepted order
  Future<void> fetchAcceptedOrder() async {
    try {
      http.Response response =
      await apiService.get("orders/fetch-accepeted-orders");
      if (response.statusCode == 200) {
        print("Order details fetched successfully: ${response.body}");
      } else {
        print("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // Fetch assigned orders (NEW METHOD)
  Future<List<Map<String, dynamic>>> fetchAssigningOrders() async {
    try {
      http.Response response =
      await apiService.get("orders/fetch-assigning-orders");

      if (response.statusCode == 200) {

        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract the list of orders from the 'data' field
        List<dynamic> ordersData = responseData['data'];

        // Map the orders data into a list of maps
        List<Map<String, dynamic>> orders = ordersData.map((order) {
          return {
            'orderId': order['id'],
            'customerName': order['customer']['name'],
            'customerEmail': order['customer']['email'],
            'customerAddress': {
              'street': order['address']['street'],
              'city': order['address']['city'],
              'state': order['address']['state'],
              'zip': order['address']['zip'],
              'reference': order['address']['reference']
            },
            'orderItems': order['order_details'].map((item) {
              return {
                'itemName': item['name'],
                'quantity': item['quantity'],
                'price': item['price'],
                'subTotal': item['sub_total'],
              };
            }).toList(),
            'status': order['status'],
            'assignedDriverId': order['driver_id'],
            'totalAmount': order['total'],
            'deliveryFee': order['delivery_fee'],
            'tax': order['tax'],
            'discount': order['discount'],
            'paymentMethod': order['payment_method'],
            'estimatedDeliveryTime': order['estimated_delivery_time'],
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
  Future<bool> acceptOrder(String orderId) async {
    try {

      String? token = await secureLocalStorage.retrieveToken();
      if (token == null) {
        print("No token found, user might need to log in.");
        return false;
      }

      print("Trying to accept order with ID: $orderId");

      final response = await http.put(
        Uri.parse('${Environment.endpointApi}/orders/accept-delivering/$orderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'status': 'delivering'}),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");


      if (response.statusCode == 200) {
        print("Order status updated to 'delivering'.");
        return true;
      } else {
        print("Failed to update order status. Status Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error accepting order: $e");
      return false;
    }
  }



}