class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  // Chuyển đổi từ Map (json) sang Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}