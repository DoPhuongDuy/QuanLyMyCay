import 'package:flutter/material.dart';
import '../models/orderitem.dart';

class FoodDetailPage extends StatelessWidget {
  final OrderItem orderItem;

  FoodDetailPage({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(orderItem.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(orderItem.image, width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(orderItem.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Số lượng: ${orderItem.quantity}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Giá: ${orderItem.price} VND', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Tổng giá: ${orderItem.price * orderItem.quantity} VND', style: TextStyle(fontSize: 20)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Thêm vào giỏ hàng hoặc xử lý thanh toán
              },
              child: Text('Thêm vào giỏ hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
