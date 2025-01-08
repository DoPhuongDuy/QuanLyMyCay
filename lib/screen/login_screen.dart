import 'package:damh4/model/Login.dart';
import 'package:flutter/material.dart';
import '../Test/RoleService.dart';
import '/Test/service.dart';
import 'Custom/CustomAppBar.dart';
import 'Custom/CustomButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RoleService roleService = RoleService();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // Thêm Text 'Login' trước ListView
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDF3E12)
                ),
              ),
            ),
            const Text('Name'),
            const SizedBox(height: 5),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Name',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Password'),
            const SizedBox(height: 5),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Password',
              ),
            ),
            const SizedBox(height: 10),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Login',
              onPressed: () async {
                if (validateForm()) {
                  Login login = Login(
                    name: nameController.text,
                    password: passwordController.text,
                  );
                  String result = await service.loginUser(login);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                  if (result == 'Đăng nhập thành công') {
                    String? role = await roleService.getRoleByToken();
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
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
