import 'package:flutter/material.dart';
import 'package:damh_flutter/screens/login_page.dart';
import 'package:damh_flutter/screens/home_page.dart';  // Bạn cần tạo trang home_page.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng Đặt Món',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(), // Bạn cần tạo trang home_page.dart
      },
    );
  }
}
