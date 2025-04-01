import 'package:http/http.dart' as http;
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

}
