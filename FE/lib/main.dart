import 'package:damh4/screen/home_screen.dart';
import 'package:damh4/screen/login_screen.dart';
import 'package:damh4/screen/register_screen.dart'; // Import màn hình đăng ký
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Đặt route ban đầu
      routes: {
        '/': (context) => const SplashScreen(), // SplashScreen để kiểm tra token
        '/login': (context) => const LoginScreen(title: 'Đăng Nhập'),
        '/register': (context) => const RegisterScreen(title: 'Đăng Ký'), // Thêm tuyến đường cho màn hình đăng ký
        '/home': (context) => const HomeScreen(title: 'Thực đơn quán'),
      },
    );
  }
}

// SplashScreen để kiểm tra token
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<String?> checkToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'token'); // Lấy token từ Secure Storage
  }

  @override
  Widget build(BuildContext context) {
    checkToken().then((token) {
      if (token != null) {
        // Nếu có token, chuyển đến HomeScreen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Nếu không có token, chuyển đến LoginScreen
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()), // Hiển thị khi đang kiểm tra
    );
  }
}
