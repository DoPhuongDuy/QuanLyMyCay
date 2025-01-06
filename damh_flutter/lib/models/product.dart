// lib/models/food.dart
import 'category.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String image; // Đường dẫn hoặc URL của ảnh món ăn
  final Category category; // Thêm đối tượng category

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category, // Khởi tạo category trong constructor
  });

  // Phương thức factory để tạo đối tượng từ JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      category: Category.fromJson(json['category']), // Lấy thông tin category từ JSON
    );
  }

  // Phương thức để chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'category': category.toJson(), // Lưu thông tin category khi chuyển thành JSON
    };
  }
}
