import 'package:flutter/material.dart';
import 'package:demo/services/order_service.dart'; // Import OrderService
import 'package:demo/models/order.dart'; // Import Order model

class StallScreen extends StatefulWidget {
  @override
  _StallScreenState createState() => _StallScreenState();
}

class _StallScreenState extends State<StallScreen> {
  late Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = OrderService.loadOrders();  // Tải đơn hàng từ OrderService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quầy')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<Order>>(
          future: orders,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi khi tải đơn hàng'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Không có đơn hàng'));
            }

            List<Order> ordersList = snapshot.data!;

            return ListView.builder(
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(ordersList[index]);
              },
            );
          },
        ),
      ),
    );
  }

  // Tạo một widget để hiển thị đơn hàng
  Widget _buildOrderCard(Order order) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ExpansionTile(
        title: Text('Đơn hàng #${order.id} - Tổng tiền: ${order.totalAmount} Đ'),
        children: [
          // Hiển thị các món ăn trong đơn hàng
          ...order.items.map((item) {
            return ListTile(
              leading: Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover), // Hiển thị hình ảnh từ URL
              title: Text('${item.name} x${item.quantity}'),
              subtitle: Text('Giá: ${item.price} Đ'),
            );
          }).toList(),
        ],
      ),
    );
  }
}
