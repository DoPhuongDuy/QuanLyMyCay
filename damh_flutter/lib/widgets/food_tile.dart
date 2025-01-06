import 'package:flutter/material.dart';
import '../models/product.dart';

class FoodTile extends StatelessWidget {
  final Product food;
  final Function(Product) addToCart;

  const FoodTile({required this.food, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      color: Colors.white, // Màu nền trắng cho từng mục
      elevation: 0, // Bỏ bóng đổ
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Hình vuông (không bo góc)
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8), // Khoảng cách nội dung trong ListTile
        title: Text(
          food.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${food.description}\n',
                style: const TextStyle(
                  color: Color(0xFF666666), // Màu #666666
                  fontSize: 11, // Kích thước font 10
                  fontWeight: FontWeight.w600,
                  height: 2
                ), // Mô tả món ăn
              ),
              TextSpan(
                text: 'Giá: ${food.price} VND',
                style: const TextStyle(
                  color: Colors.red, // Màu đỏ cho giá
                  fontWeight: FontWeight.bold, // In đậm giá
                  fontSize: 16,
                  height: 2
                ),
              ),
            ],
          ),
        ),
        leading: Image.network(
          food.image,
          width: 70, // Chiều rộng cố định
          height: 70, // Chiều cao cố định (chỉnh lại chiều cao)
          fit: BoxFit.cover, // Cắt ảnh để giữ tỷ lệ vuông
        ),
        trailing: ElevatedButton(
          onPressed: () => addToCart(food),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDF3E12),
            minimumSize: const Size(35, 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.zero,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 19,
          ),
        ),
      ),
    );
  }
}