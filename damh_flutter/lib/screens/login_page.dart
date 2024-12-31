// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';  // Import CustomAppBar từ thư mục widgets

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  // Hàm xử lý đăng nhập
  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'admin' && password == 'admin123') {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _errorMessage = 'Tên đăng nhập hoặc mật khẩu không đúng.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Đăng Nhập',), // Sử dụng CustomAppBar từ widgets
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 12.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tiêu đề
                  Text(
                    'Chào mừng trở lại!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  SizedBox(height: 40),

                  // Trường nhập tên người dùng
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Tên người dùng',
                      hintText: 'Nhập tên người dùng',
                      prefixIcon: Icon(Icons.person, color: Colors.redAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Trường nhập mật khẩu
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      hintText: 'Nhập mật khẩu',
                      prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Thông báo lỗi nếu có
                  if (_errorMessage.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),

                  // Nút đăng nhập
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Đăng nhập', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
