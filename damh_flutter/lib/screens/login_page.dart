import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Các biến để lưu trữ thông tin người dùng nhập vào
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Biến để lưu thông báo lỗi khi đăng nhập không thành công
  String _errorMessage = '';

  // Hàm xử lý đăng nhập
  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Kiểm tra thông tin người dùng, đây chỉ là ví dụ, bạn có thể thay thế bằng API thực tế
    if (username == 'admin' && password == 'admin123') {
      // Nếu đăng nhập thành công, chuyển hướng đến trang khác (ví dụ: trang chính)
      Navigator.pushReplacementNamed(context, '/home'); // Bạn cần định nghĩa đường dẫn '/home'
    } else {
      // Nếu thông tin không hợp lệ, hiển thị thông báo lỗi
      setState(() {
        _errorMessage = 'Tên đăng nhập hoặc mật khẩu không đúng.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Nhập'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Trường nhập tên người dùng
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Tên người dùng',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Trường nhập mật khẩu
            TextFormField(
              controller: _passwordController,
              obscureText: true, // Ẩn mật khẩu khi gõ
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Thông báo lỗi nếu đăng nhập không thành công
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),

            // Nút đăng nhập
            ElevatedButton(
              onPressed: _login,
              child: Text('Đăng nhập'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}
