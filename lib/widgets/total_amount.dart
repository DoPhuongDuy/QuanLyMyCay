import 'package:flutter/material.dart';

class TotalAmount extends StatelessWidget {
  final String totalAmount;

  // Constructor nhận giá trị tổng tiền
  TotalAmount({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF800000), // Màu nền đỏ cho phần tổng tiền
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tổng tiền',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            '$totalAmount Đ', // Hiển thị tổng tiền
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
