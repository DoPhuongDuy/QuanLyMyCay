import 'package:flutter/material.dart';
import '../models/orderitem.dart';
import '../widgets/cart_item_tile.dart';

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

  // Hàm thay đổi số lượng món ăn trong giỏ hàng
  void updateItemQuantity(int index, int delta) {
    setState(() {
      final item = widget.cartItems[index];
      if (item.quantity + delta <= 0) {
        widget.cartItems.removeAt(index); // Nếu số lượng <= 0 thì xóa món ăn khỏi giỏ hàng
      } else {
        item.quantity += delta; // Tăng hoặc giảm số lượng
      }
    });
  }

  // Hàm xóa tất cả các món trong giỏ hàng với xác nhận
  void clearCart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa giỏ hàng'),
          content: Text('Bạn có chắc chắn muốn xóa tất cả các món trong giỏ hàng không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.cartItems.clear(); // Xóa tất cả món trong giỏ hàng
                });
                Navigator.of(context).pop(); // Đóng hộp thoại sau khi xóa
              },
              child: Text('Xóa tất cả'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề giỏ hàng và nút "Xóa tất cả" nằm ngang
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: clearCart, // Xử lý khi nhấn vào nút "Xóa tất cả"
                child: Text(
                  widget.cartItems.isEmpty ? 'Giỏ hàng trống' : 'Xóa tất cả',  // Hiển thị tùy thuộc vào trạng thái giỏ hàng
                  style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Giỏ Hàng',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Hiển thị danh sách món ăn trong giỏ hàng
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return CartItemTile(
                  item: item,
                  onIncrease: () => updateItemQuantity(index, 1), // Tăng số lượng
                  onDecrease: () => updateItemQuantity(index, -1), // Giảm số lượng
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

