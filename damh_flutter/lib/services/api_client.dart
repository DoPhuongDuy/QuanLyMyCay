import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_item.dart';

class APIClient {
  final String baseUrl = 'http://localhost:3000/menu';  // Đảm bảo API chạy tại localhost:3000

  Future<List<MenuItem>> fetchMenuByCategory(String category) async {
    // Thêm tham số truy vấn category vào URL để lọc theo danh mục
    final response = await http.get(Uri.parse('$baseUrl/$category'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => MenuItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load menu');
    }
  }
}
