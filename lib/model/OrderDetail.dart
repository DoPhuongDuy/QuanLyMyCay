import 'Product.dart';         // Giả sử bạn đã tạo model Product
import 'SpiceLevel.dart';      // Giả sử bạn đã tạo model SpiceLevel
import 'Order.dart';           // Giả sử bạn đã tạo model Order

class OrderDetail {
  String note;               // Ghi chú về chi tiết đơn hàng
  int numberOfProducts;         // Số lượng sản phẩm trong đơn hàng
  double totalMoney;         // Tổng tiền của chi tiết đơn hàng
  int? spiceLevel;     // Mức độ cay của sản phẩm
  final Product product;           // Sản phẩm trong chi tiết đơn hàng

  OrderDetail({
    required this.note,
    required this.numberOfProducts,
    required this.totalMoney,
    required this.spiceLevel,
    required this.product,
  });

  // Hàm tạo đối tượng OrderDetail từ JSON
  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      note: json['note'],
      numberOfProducts: json['numberOfProducts'],
      totalMoney: json['totalMoney'],
      spiceLevel: json['spiceLevel'], // SpiceLevel cần được định nghĩa
      product: Product.fromJson(json['product']),  // Product cần được định nghĩa
    );
  }

  // Hàm chuyển đối tượng OrderDetail thành JSON
  Map<String, dynamic> toJson() {
    return {
      'note': note,
      'numberOfProducts': numberOfProducts,
      'totalMoney': totalMoney,
      'spiceLevelId': null,
      'productId': product.getId(),
    };
  }
  void updateQuantity(int quantity) {
    numberOfProducts += quantity;
  }
}
