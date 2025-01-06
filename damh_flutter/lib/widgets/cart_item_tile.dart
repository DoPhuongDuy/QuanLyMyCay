import 'package:flutter/material.dart';
import '../models/cartitem.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final Function() onIncrease;
  final Function() onDecrease;

  const CartItemTile({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  // Tạo một hàm riêng cho IconButton để tái sử dụng mã
  Widget _buildIconButton({
    required IconData icon,
    required Function() onPressed,
    required Color backgroundColor,
    required Color iconColor,
    double size = 16.0,
  }) {
    return IconButton(
      icon: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: iconColor, // Màu viền
            width: 1, // Độ dày viền
          ),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size,
        ),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Nút giảm số lượng
                _buildIconButton(
                  icon: Icons.remove,
                  onPressed: onDecrease, // Giảm số lượng
                  backgroundColor: Colors.white,
                  iconColor: Colors.red,
                ),
                Text('${item.quantity}', style: TextStyle(fontSize: 18)),
                // Nút tăng số lượng
                _buildIconButton(
                  icon: Icons.add,
                  onPressed: onIncrease, // Tăng số lượng
                  backgroundColor: Color(0xFFDF3E12),
                  iconColor: Colors.white,
                ),
              ],
            ),
            Text('Giá: ${item.price * item.quantity} VND'),
          ],
        ),
      ),
    );
  }
}
