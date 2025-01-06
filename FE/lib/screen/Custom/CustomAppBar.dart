import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  Future<void> logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token'); // Xóa token khỏi Secure Storage
    Navigator.pushReplacementNamed(context, '/login'); // Điều hướng về trang đăng nhập
  }

  Future<bool> hasToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    return token != null; // Kiểm tra xem có token hay không
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Đặt màu chữ là trắng
          ),
          Spacer(), // Tạo khoảng cách giữa tiêu đề và ảnh
          // Image.asset(
          //   'assets/images/1.jpg', // Đường dẫn đến hình ảnh trong thư mục assets
          //   width: 10,
          //   height: 10,
          // ),
          Image.network(
            'https://www.beeart.vn/Uploads/project/20240918/e6782887-da10-4d10-9ceb-03a9283123e7.jpg',
            width: 40,
            height: 40,
          ),
        ],
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFAE0007), // Màu trên cùng
              Color(0xFFDF3E12), // Màu dưới cùng
            ],
            begin: Alignment.topCenter, // Bắt đầu gradient từ trên
            end: Alignment.bottomCenter, // Kết thúc gradient ở dưới
          ),
        ),
      ),
      elevation: 0, // Loại bỏ bóng mờ nếu không cần
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
