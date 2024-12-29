class Food {
  final int id;
  final String name;
  final double price;
  final String description;
  final String image; // Đường dẫn hoặc URL của ảnh món ăn

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image, // Khởi tạo ảnh trong constructor
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'], // Lấy ảnh từ dữ liệu JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image, // Lưu ảnh khi chuyển thành JSON
    };
  }
}
