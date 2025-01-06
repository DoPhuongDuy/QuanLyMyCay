import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/Test/service.dart';   // Import Service để lấy token

class CheckToken {
  final Service _service = Service();  // Service để lấy token

  // Kiểm tra token khi màn hình được tải
  Future<void> checkToken(BuildContext context, Function fetchData) async {
    String? token = await _service.getToken(); // Lấy token từ Service
    if (token == null) {
      // Nếu không có token, điều hướng đến màn hình đăng nhập
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Nếu có token, gọi fetchData
      fetchData();
    }
  }

  // Xử lý logout
  Future<void> logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token'); // Xóa token khỏi Secure Storage
    Navigator.pushReplacementNamed(context, '/login'); // Điều hướng về trang đăng nhập
  }
}
