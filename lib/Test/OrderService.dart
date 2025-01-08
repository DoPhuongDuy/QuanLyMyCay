import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  // Import FlutterSecureStorage
import '../api_endpoints/api_endpoints.dart';
import '../model/Order.dart';

class OrderService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();  // Khởi tạo FlutterSecureStorage

  Future<List<Order>> getAllActiveOrders() async {

    var uri = Uri.parse(ApiEndpoints.getAllActiveOrders);

    try {

      String? token = await _storage.read(key: 'token');

      if (token == null) {
        throw Exception ("no token");
      }

      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // Convert JSON response to List of Order objects
        return data.map((orderJson) => Order.fromJson(orderJson)).toList();
      } else {
        throw Exception("Failed to load orders");
      }
    } catch (e) {
      throw Exception("Error fetching orders: $e");
    }
  }

  Future<bool> createOrder(Order order) async {
    try {
      // Lấy token từ secure storage
      String? token = await _storage.read(key: 'token');

      if (token == null) {
        print('No token found');
        return false;  // Nếu không có token, không gửi yêu cầu
      }

      final response = await http.post(
        Uri.parse(ApiEndpoints.createOrder),  // Sử dụng endpoint từ ApiEndpoints
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Thêm token vào header
        },
        body: jsonEncode(order.toJson()), // Sử dụng phương thức toJson() của Order
      );

      if (response.statusCode == 200) {
        // Xử lý khi tạo đơn hàng thành công
        print('Order created successfully');
        return true;
      } else {
        // Xử lý lỗi nếu không thành công
        print('Failed to create order');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
