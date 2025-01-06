class OrderDetailItem {
  final int hoaDonId; // ID hóa đơn (HoaDonID)
  final int monAnId; // ID món ăn (MonAnID)
  final String? ghiChu; // Ghi chú (GhiChu)
  final int soLuong; // Số lượng (SoLuong)
  final double donGia; // Đơn giá (DonGia)
  final double thanhTien; // Thành tiền (ThanhTien)
  final DateTime createdAt; // Ngày tạo (CreatedAt)
  final DateTime modifiedAt; // Ngày sửa đổi (ModifiedAt)

  OrderDetailItem({
    required this.hoaDonId,
    required this.monAnId,
    this.ghiChu,
    required this.soLuong,
    required this.donGia,
    required this.thanhTien,
    required this.createdAt,
    required this.modifiedAt,
  });

  // Chuyển đổi từ JSON sang OrderDetailItem
  factory OrderDetailItem.fromJson(Map<String, dynamic> json) {
    return OrderDetailItem(
      hoaDonId: json['HoaDonID'],
      monAnId: json['MonAnID'],
      ghiChu: json['GhiChu'],
      soLuong: json['SoLuong'],
      donGia: json['DonGia'],
      thanhTien: json['ThanhTien'],
      createdAt: DateTime.parse(json['CreatedAt']),
      modifiedAt: DateTime.parse(json['ModifiedAt']),
    );
  }

  // Chuyển đổi từ OrderDetailItem sang JSON
  Map<String, dynamic> toJson() {
    return {
      'HoaDonID': hoaDonId,
      'MonAnID': monAnId,
      'GhiChu': ghiChu,
      'SoLuong': soLuong,
      'DonGia': donGia,
      'ThanhTien': thanhTien,
      'CreatedAt': createdAt.toIso8601String(),
      'ModifiedAt': modifiedAt.toIso8601String(),
    };
  }
}
