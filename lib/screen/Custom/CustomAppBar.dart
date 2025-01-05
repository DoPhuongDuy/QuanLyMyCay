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
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        FutureBuilder<bool>(
          future: hasToken(), // Kiểm tra xem có token hay không
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Hiển thị vòng tròn tải khi đang kiểm tra
            } else if (snapshot.hasError) {
              return Icon(Icons.error); // Hiển thị lỗi nếu có
            } else if (snapshot.data == true) {
              return PopupMenuButton(
                icon: ClipOval(
                  child: Image.asset(
                    'lib/assets/logo.jpg', // Đường dẫn đến logo
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                ),
                onSelected: (value) {
                  if (value == 'logout') {
                    logout(context); // Gọi hàm logout
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'logout',
                      child: Text('Đăng xuất'),
                    ),
                  ];
                },
              );
            } else {
              return Container(); // Nếu không có token, không hiển thị gì
            }
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFAE0007),
              Color(0xFFDF3E12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
