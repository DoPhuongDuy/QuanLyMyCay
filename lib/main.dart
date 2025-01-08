import 'package:damh4/screen/AdminScreen.dart';
import 'package:damh4/screen/HomeScreen.dart';
import 'package:damh4/screen/KitchenOrderScreen.dart';
import 'package:damh4/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Test/RoleService.dart'; // Import the RoleService

void main() {
  // Initialize the RoleService
  final RoleService roleService = RoleService();

  runApp(MyApp(roleService: roleService));
}

class MyApp extends StatelessWidget {
  final RoleService roleService;

  const MyApp({super.key, required this.roleService});

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
        '/': (context) => SplashScreen(roleService: roleService), // Pass RoleService to SplashScreen
        '/login': (context) => const LoginScreen(title: 'Đăng Nhập'),
        '/home': (context) => const HomeScreen(title: 'Thực đơn quán'),
        '/admin': (context) => const AdminScreen(title: 'Quản lý'),
        '/kitchen': (context) => const KitchenOrderScreen(title: 'Bếp'),
      },
    );
  }
}
class SplashScreen extends StatelessWidget {
  final RoleService roleService;

  const SplashScreen({super.key, required this.roleService});

  Future<String?> checkToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: 'token'); // Lấy token từ Secure Storage
  }

  Future<void> checkAndNavigate(BuildContext context) async {
    String? token = await checkToken();

    if (token != null) {
      try {
        String? role = await roleService.getRoleByToken(); // Use the injected RoleService

        if (role == 'ADMIN') {
          Navigator.pushReplacementNamed(context, '/admin');
        } else if (role == 'USER') {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (role == 'KITCHEN') {
          Navigator.pushReplacementNamed(context, '/kitchen');
        } else {
          print('Undefined role');
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (e) {
        print('Error fetching role: $e');
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      // If no token is found, navigate to the login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => checkAndNavigate(context));

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()), // Display a loader while checking
    );
  }
}
