import 'Category.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String thumbnail; // Có thể không có thumbnail
  final Category category; // Loại category, cần thêm model Category
  int? SpiceLevelId;
  final bool status;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.SpiceLevelId,
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
      SpiceLevelId: null,
      status: json['status'],
    );
  }

  // Hàm chuyển đối tượng Product thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'thumbnail': thumbnail,
      'category': category.toJson(),  // Chuyển Category thành JSON
      'status': status,
    };
  }
  int getId() {
    return id;
  }
}
