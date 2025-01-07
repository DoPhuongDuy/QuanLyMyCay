import 'package:flutter/material.dart';
import 'package:demo/models/order.dart'; // Import Order model

class OrderTable extends StatelessWidget {
  final Order order;

  // Constructor nhận đối tượng Order
  OrderTable({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ExpansionTile(
        title: Text('Đơn hàng #${order.id} - Tổng tiền: ${order.totalAmount} Đ'),
        children: [
          // Hiển thị các món ăn trong đơn hàng
          ...order.items.map((item) {
            return ListTile(
              leading: Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover), // Hình ảnh từ URL
              title: Text('${item.name} x${item.quantity}'),
              subtitle: Text('Giá: ${item.price} Đ'),
            );
          }).toList(),
        ],
      ),
    );
  }
}
