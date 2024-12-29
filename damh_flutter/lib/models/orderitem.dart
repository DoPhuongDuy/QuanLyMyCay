class OrderItem {
  final int id;
  final String name;
  final double price;
  final String image;
  int quantity; // Không dùng `late`, mà khởi tạo giá trị ngay từ đầu.

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1, // Giá trị mặc định là 1
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'] ?? 1, // Đảm bảo có giá trị mặc định
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
