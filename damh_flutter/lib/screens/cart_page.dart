import 'package:flutter/material.dart';
import '../models/orderitem.dart';

class CartDetailsPage extends StatefulWidget {
  final List<OrderItem> cartItems;

  CartDetailsPage({required this.cartItems});

  @override
  _CartDetailsPageState createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  // Hàm tính tổng giá trị giỏ hàng
  double calculateTotal() {
    return widget.cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề giỏ hàng
          Text(
            'Giỏ Hàng',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // Hiển thị danh sách món ăn trong giỏ hàng
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hiển thị số lượng với dấu cộng và dấu trừ
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                // Giảm số lượng món ăn trong giỏ hàng
                                setState(() {
                                  if (item.quantity > 1) {
                                    item.quantity--;
                                  } else {
                                    // Nếu số lượng bằng 1, xóa món ăn khỏi giỏ hàng
                                    widget.cartItems.removeAt(index);
                                  }
                                });
                              },
                            ),
                            Text('${item.quantity}', style: TextStyle(fontSize: 18)),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // Tăng số lượng món ăn trong giỏ hàng
                                setState(() {
                                  item.quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                        Text('Giá: ${item.price * item.quantity} VND'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Hiển thị tổng số tiền
          SizedBox(height: 16),
          Text(
            'Tổng cộng: ${calculateTotal()} VND', // Sử dụng hàm tính tổng ở đây
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
