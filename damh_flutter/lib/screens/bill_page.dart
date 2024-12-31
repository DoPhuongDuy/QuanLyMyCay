// import 'package:flutter/material.dart';
// import '../models/bill.dart';
// import '../services/order_service.dart';
//
// class BillPage extends StatelessWidget {
//   final int orderId;
//
//   BillPage({required this.orderId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hóa Đơn'),
//       ),
//       body: FutureBuilder<Bill>(
//         future: OrderService().getBill(orderId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Lỗi khi tải hóa đơn'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('Không có hóa đơn nào'));
//           } else {
//             final bill = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Hóa Đơn #${bill.id}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 16),
//                   Text('Tổng tiền: ${bill.totalAmount} VND', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 16),
//                   Text('Ngày lập hóa đơn: ${bill.dateIssued.toLocal().toString()}', style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
