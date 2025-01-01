import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';  // Import CustomAppBar từ thư mục widgets
import '../services/auth_service.dart';  // Import AuthService

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  final AuthService _authService = AuthService();  // Khởi tạo AuthService

  // Hàm xử lý đăng nhập
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      bool isLoggedIn = await _authService.login(username, password); // Gọi hàm login từ AuthService

      if (isLoggedIn) {
        // Nếu đăng nhập thành công, chuyển hướng đến trang chính
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = 'Tên đăng nhập hoặc mật khẩu không đúng';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi kết nối tới API';
      });
    }
  }

  // Hàm chuyển đến trang đăng ký
  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Đăng Nhập'),
      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.network(
              'https://inkythuatso.com/uploads/thumbnails/800/2022/06/hinh-nen-do-an-anime-cho-dien-thoai-5-inkythuatso-10-11-30-23.jpg',
              fit: BoxFit.cover, // Đảm bảo ảnh phủ đầy màn hình
            ),
          ),
          // Nội dung đăng nhập (Card)
          Center(
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

                      // Liên kết tới trang đăng ký
                      TextButton(
                        onPressed: _navigateToRegister,  // Chuyển tới trang đăng ký
                        child: Text(
                          'Chưa có tài khoản? Đăng ký ngay',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),

                      // Các nút đăng nhập bằng Gmail và Facebook
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Nút đăng nhập với Gmail
                          ElevatedButton.icon(
                            onPressed: () {
                              // Thực hiện chức năng đăng nhập bằng Gmail
                            },
                            icon: Icon(Icons.email, color: Colors.white),
                            label: Text('Gmail', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,  // Màu nền của nút
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),

                          // Nút đăng nhập với Facebook
                          ElevatedButton.icon(
                            onPressed: () {
                              // Thực hiện chức năng đăng nhập bằng Facebook
                            },
                            icon: Icon(Icons.facebook, color: Colors.white),
                            label: Text('Facebook', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1877F2),  // Màu nền Facebook
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
