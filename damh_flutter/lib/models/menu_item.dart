class MenuItem {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  MenuItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}
