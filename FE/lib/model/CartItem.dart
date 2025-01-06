import 'Product.dart';

class CartItem {
  final Product product; // Sản phẩm trong giỏ hàng
  int quantity; // Số lượng sản phẩm

  CartItem({
    required this.product,
    required this.quantity,
  });

  // Tính tổng giá trị của sản phẩm trong giỏ hàng
  double get totalPrice => product.price * quantity;

  // Chuyển đổi từ JSON sang CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']), // Tạo Product từ JSON
      quantity: json['quantity'], // Số lượng
    );
  }

  // Chuyển đổi từ CartItem sang JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product, // Chuyển Product sang JSON
      'quantity': quantity, // Số lượng
    };
  }
}
