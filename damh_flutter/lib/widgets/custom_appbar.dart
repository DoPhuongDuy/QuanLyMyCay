import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

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
