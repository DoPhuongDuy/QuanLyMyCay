import 'package:flutter/material.dart';
import '../api_endpoints/api_endpoints.dart';
import '../model/Order.dart';

class OrderScreen extends StatelessWidget {
  final Order order;

  const OrderScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mã Đơn hàng #${order.invoice}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Dịch nút qua bên trái
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home'); // Đưa người dùng về trang Home (dựa trên route đã định nghĩa)
              },
              child: Icon(
                Icons.home,
                size: 36, // Tăng kích thước icon
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF1F5F9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quý Khách hãy nhớ mã hóa đơn của mình để xác nhận',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Màu xám
              ),
            ),
            SizedBox(height: 8),
            Text('Total Money: \$${order.totalMoney.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Status: ${order.isActive ? "Active" : "Inactive"}',
                style: TextStyle(
                    fontSize: 16, color: order.isActive ? Colors.green : Colors.red)),
            SizedBox(height: 16),
            Text(
              'Order Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: order.orderDetails.length,
                itemBuilder: (context, index) {
                  final orderDetail = order.orderDetails[index];
                  return ListTile(
                    leading: orderDetail.product.thumbnail != null
                        ? Image.network(
                      ApiEndpoints.getProductImageUrl(orderDetail.product.thumbnail!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ) // Hình ảnh sản phẩm
                        : Icon(Icons.image, size: 50), // Nếu không có hình ảnh, hiển thị icon mặc định
                    title: Text(
                      orderDetail.product.name,
                      style: TextStyle(
                        color: Colors.black, // Màu chữ đen
                        fontSize: 14, // Cỡ chữ 12
                        fontWeight: FontWeight.w600, // Semi-bold
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderDetail.note?.isNotEmpty ?? false ? orderDetail.note! : 'Thêm ghi chú',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFC2C2C2)
                          ),
                          overflow: TextOverflow.ellipsis, // Thêm ba chấm nếu văn bản quá dài
                          maxLines: 1, // Giới hạn chỉ hiển thị 1 dòng
                        ),
                        SizedBox(height: 8), // Thêm khoảng cách giữa ghi chú và giá
                        Text(
                          '${orderDetail.product.price}đ',
                          style: TextStyle(
                            color: Color(0xFFDF3E12), // Màu chữ #DF3E12
                            fontSize: 14, // Cỡ chữ 14
                            fontWeight: FontWeight.w600, // Semi-bold
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Để các nút không chiếm hết không gian
                      children: [
                        if (orderDetail.product.category.id == 1 || orderDetail.product.category.id == 2)
                          Text(
                            'Cấp độ: ${orderDetail.spiceLevel ?? 0}  ',
                            style: TextStyle(
                              color: Colors.black, // Màu chữ đen
                              fontSize: 14, // Cỡ chữ 12
                              fontWeight: FontWeight.w600, // Medium (fontWeight w500 cho medium)
                            ),
                          ),
                        SizedBox(height: 8),
                        Text(
                          'Số lượng: ${orderDetail.numberOfProducts}',
                          style: TextStyle(
                            color: Colors.black, // Màu chữ đen
                            fontSize: 14, // Cỡ chữ 12
                            fontWeight: FontWeight.w600, // Medium (fontWeight w500 cho medium)
                          ),
                        ), // Hiển thị số lượng sản phẩm
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
