import 'package:flutter/material.dart';
import 'package:demo/services/order_service.dart'; // Import OrderService
import 'package:demo/models/cartitem.dart'; // Import CartItem model

class KitchenScreen extends StatefulWidget {
  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  late Future<List<CartItem>> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = OrderService.loadCartItems();  // Tải danh sách CartItem
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bếp')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<CartItem>>(
          future: cartItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi khi tải dữ liệu'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Không có sản phẩm trong giỏ hàng'));
            }

            List<CartItem> items = snapshot.data!;

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildCartItemCard(items[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text('${item.name} x${item.quantity}'),
        subtitle: Text('Giá: ${item.price} Đ'),
      ),
    );
  }
}
