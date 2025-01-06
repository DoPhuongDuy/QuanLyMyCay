class Order {
  final int id; // Tương ứng với HoaDonID
  final String maHoaDon; // Mã hóa đơn (MaHoaDon)
  final DateTime ngayLap; // Ngày lập hóa đơn (NgayLap)
  final double tongTien; // Tổng tiền hóa đơn (TongTien)
  final String? ghiChu; // Ghi chú (GhiChu)
  final int? banId; // ID của bàn (BanID)
  final DateTime createdAt; // Ngày tạo (CreatedAt)
  final DateTime modifiedAt; // Ngày sửa đổi (ModifiedAt)

  Order({
    required this.id,
    required this.maHoaDon,
    required this.ngayLap,
    required this.tongTien,
    this.ghiChu,
    this.banId,
    required this.createdAt,
    required this.modifiedAt,
  });

  // Chuyển đổi từ JSON sang Order
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['HoaDonID'],
      maHoaDon: json['MaHoaDon'],
      ngayLap: DateTime.parse(json['NgayLap']),
      tongTien: json['TongTien'],
      ghiChu: json['GhiChu'],
      banId: json['BanID'],
      createdAt: DateTime.parse(json['CreatedAt']),
      modifiedAt: DateTime.parse(json['ModifiedAt']),
    );
  }

  // Chuyển đổi từ Order sang JSON
  Map<String, dynamic> toJson() {
    return {
      'HoaDonID': id,
      'MaHoaDon': maHoaDon,
      'NgayLap': ngayLap.toIso8601String(),
      'TongTien': tongTien,
      'GhiChu': ghiChu,
      'BanID': banId,
      'CreatedAt': createdAt.toIso8601String(),
      'ModifiedAt': modifiedAt.toIso8601String(),
    };
  }
}
