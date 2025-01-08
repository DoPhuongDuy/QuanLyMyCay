import 'OrderDetail.dart';

class Order {
  final int id;              // ID của đơn hàng
  final String invoice;      // Mã hóa đơn (đảm bảo uniqueness)
  double totalMoney;   // Tổng tiền của đơn hàng
  final String note;         // Ghi chú của đơn hàng   // Người dùng tạo đơn hàng (Quan hệ với model User)
  final bool isActive;       // Trạng thái của đơn hàng (đã xóa hay chưa)
  final List<OrderDetail> orderDetails; // Danh sách chi tiết đơn hàng (OrderDetail)

  Order({
    required this.id,
    required this.invoice,
    required this.totalMoney,
    required this.note,
    required this.isActive,
    required this.orderDetails,
  });

  // Hàm tạo đối tượng Order từ JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    var detailsFromJson = json['orderDetails'] as List;
    List<OrderDetail> orderDetailsList = detailsFromJson.map((i) => OrderDetail.fromJson(i)).toList();

    return Order(
      id: json['id'] ,
      invoice: json['invoice'] ,
      totalMoney: json['totalMoney'] ,
      note: json['note'] ?? '',
      isActive: json['isActive'] ?? true,
      orderDetails: orderDetailsList,
    );
  }

  // Hàm chuyển đối tượng Order thành JSON
  Map<String, dynamic> toJson() {
    return {
      'invoice': invoice,
      'note': note,
      'orderDetails': orderDetails.map((e) => e.toJson()).toList(),
    };
  }
}