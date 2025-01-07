import 'dart:convert';
import 'package:flutter/services.dart'; // Để đọc tệp assets
import 'package:demo/models/cartitem.dart'; // Import CartItem model

class OrderService {
  // Phương thức tải đơn hàng từ db.json
  static Future<List<CartItem>> loadCartItems() async {
    try {
      String jsonString = await rootBundle.loadString('assets/db.json');
      final jsonResponse = json.decode(jsonString); // Giải mã JSON thành Map

      List<CartItem> cartItems = [];
      // Lặp qua danh sách các CartItem và chuyển đổi thành đối tượng CartItem
      for (var itemJson in jsonResponse['items']) {
        cartItems.add(CartItem.fromJson(itemJson)); // Chuyển JSON thành CartItem
      }

      return cartItems;
    } catch (e) {
      print("Lỗi khi tải CartItem: $e");
      return [];
    }
  }
}
