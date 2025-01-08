// lib/widgets/custom_button.dart

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDF3E12), // Màu nền của button
        foregroundColor: Colors.white, // Màu chữ của button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bo tròn góc
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Điều chỉnh padding
        elevation: 5, // Độ nổi của button
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18, // Kích thước chữ của button
          fontWeight: FontWeight.bold, // Định dạng chữ
        ),
      ),
    );
  }
}
