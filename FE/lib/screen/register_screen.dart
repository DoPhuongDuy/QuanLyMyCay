import 'package:flutter/material.dart';
import '/Test/service.dart';
import '../model/RegisterDTO.dart';
import 'Custom/CustomAppBar.dart';
import 'Custom/CustomButton.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

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
    if (passwordController.text != retypePasswordController.text) {
      setState(() {
        errorMessage = 'Mật khẩu và xác nhận mật khẩu không khớp.';
      });
      return false;
    }
    if (roleController.text.isEmpty) {
      setState(() {
        errorMessage = 'Vui lòng nhập vai trò.';
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
            // Thêm Text 'Register' trước ListView
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Register',
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
            const Text('Retype Password'),
            const SizedBox(height: 5),
            TextField(
              controller: retypePasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Retype Password',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Role'),
            const SizedBox(height: 5),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Role',
              ),
            ),
            const SizedBox(height: 10),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Register',
              onPressed: () async {
                if (validateForm()) {
                  RegisterDTO user = RegisterDTO(
                    name: nameController.text,
                    password: passwordController.text,
                    retypePassword: retypePasswordController.text,
                    roleId: roleController.text,
                  );
                  String result = await service.saveUser(user);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                }
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                'Quay lại Đăng nhập',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
