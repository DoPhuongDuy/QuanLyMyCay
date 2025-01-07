class Bill {
  final int id;
  final int orderId;
  final double totalAmount;
  final DateTime dateIssued;

  Bill({required this.id, required this.orderId, required this.totalAmount, required this.dateIssued});

    factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      orderId: json['orderId'],
      totalAmount: json['totalAmount'],
      dateIssued: DateTime.parse(json['dateIssued']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'totalAmount': totalAmount,
      'dateIssued': dateIssued.toIso8601String(),
    };
  }
}
