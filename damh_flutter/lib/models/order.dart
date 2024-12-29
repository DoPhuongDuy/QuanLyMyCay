import 'package:damh_flutter/models/orderitem.dart';
class Order {
  final int id;
  final int tableId;
  final List<OrderItem> items;
  final double totalAmount;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.tableId,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      tableId: json['tableId'],
      items: (json['items'] as List).map((item) => OrderItem.fromJson(item)).toList(),
      totalAmount: json['totalAmount'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tableId': tableId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
    };
  }
}
