import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food.dart';
import '../models/orderitem.dart';
import '../models/bill.dart';

class OrderService {
  static final List<OrderItem> _cartItems = [];

  // Lấy danh sách món ăn từ API giả lập (db.json)
  Future<List<Food>> getFoodItems() async {
    final response = await http.get(Uri.parse('https://my-json-server.typicode.com/TylerTuanPhan/LapTrinhDiDong/food'));

    if (response.statusCode == 200) {
      // Nếu thành công, chuyển đổi dữ liệu JSON thành danh sách món ăn
      List jsonData = json.decode(response.body);
      return jsonData.map((food) => Food.fromJson(food)).toList();
    } else {
      // Nếu có lỗi, ném ngoại lệ
      throw Exception('Không thể tải danh sách món ăn');
    }
  }

  // Thêm món ăn vào giỏ hàng
  void addToCart(OrderItem item) {
    _cartItems.add(item);
  }

  Future<List<OrderItem>> getCartItems() async {
    return _cartItems;
  }

  // Tạo đơn hàng và trả về hóa đơn
  Future<void> createOrder(List<OrderItem> items) async {
    double totalAmount = items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    Bill bill = Bill(id: 1, orderId: 101, totalAmount: totalAmount, dateIssued: DateTime.now());
    print('Đơn hàng đã được tạo. Tổng tiền: $totalAmount');
    // Reset giỏ hàng sau khi đặt
    _cartItems.clear();
  }

  Future<Bill> getBill(int orderId) async {
    // Giả lập lấy hóa đơn từ API
    return Bill(id: 1, orderId: orderId, totalAmount: 100000, dateIssued: DateTime.now());
  }
}
