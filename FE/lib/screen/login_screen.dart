import 'package:damh4/model/Login.dart';
import 'package:flutter/material.dart';
import '/Test/service.dart';
import 'Custom/CustomAppBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Service service = Service();

  String errorMessage = '';

  bool validateForm() {
    if (nameController.text.isEmpty) {
      setState(() {
        errorMessage = 'Tên không thể để trống.';
      });
      return false;
    }
    if (passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Mật khẩu không thể để trống.';
      });
      return false;
    }
    setState(() {
      errorMessage = '';
    });
    return true;
  }

  void _login() async {
    if (validateForm()) {
      Login login = Login(
        name: nameController.text,
        password: passwordController.text,
      );
      String result = await service.loginUser(login);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      if (result == 'Đăng nhập thành công') {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Đăng Nhập'),
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
                      const Text(
                        'Chào mừng trở lại!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(height: 40),

                      // Trường nhập tên người dùng
                      TextFormField(
                        controller: nameController,
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
                        controller: passwordController,
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
                      if (errorMessage.isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red, fontSize: 14),
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
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
                              backgroundColor: Colors.red,
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
                              backgroundColor: Color(0xFF1877F2),
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
