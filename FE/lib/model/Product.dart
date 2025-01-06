import 'Category.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String? thumbnail; // Có thể không có thumbnail
  final Category category; // Loại category, cần thêm model Category
  final bool status;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.thumbnail,
    required this.category,
    required this.status,
  });

  // Hàm tạo đối tượng Product từ JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      category: Category.fromJson(json['category']), // Cần tạo category từ JSON
      status: json['status'],
    );
  }
}
