// lib/models/cartitem.dart
import 'category.dart';
import 'product.dart';

class CartItem {
  final int id;
  final String name;
  int quantity;  // Không khai báo final để có thể thay đổi số lượng
  final double price;
  final String image;
  final Category category; // Đối tượng Category

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,  // Khởi tạo quantity trong constructor
    required this.price,
    required this.image,
    required this.category,  // Khởi tạo category
  });

  // Phương thức factory để tạo đối tượng từ JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      image: json['image'],
      category: Category.fromJson(json['category']), // Lấy thông tin category từ JSON
    );
  }

  // Phương thức để chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,  // Lưu quantity khi chuyển thành JSON
      'price': price,
      'image': image,
      'category': category.toJson(), // Lưu thông tin category khi chuyển thành JSON
    };
  }
}
