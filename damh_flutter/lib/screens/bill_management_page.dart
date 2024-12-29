// import 'package:flutter/material.dart';
// import 'package:damh_flutter/models/bill.dart';
//
// class BillManagementPage extends StatelessWidget {
//   final List<Bill> bills = [
//     Bill(id: 1, orderId: 101, totalAmount: 250000, dateIssued: DateTime.now()),
//     Bill(id: 2, orderId: 102, totalAmount: 150000, dateIssued: DateTime.now()),
//     // Thêm hóa đơn khác tại đây
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quản Lý Hóa Đơn'),
//       ),
//       body: ListView.builder(
//         itemCount: bills.length,
//         itemBuilder: (context, index) {
//           final bill = bills[index];
//           return ListTile(
//             title: Text('Hóa Đơn #${bill.id}'),
//             subtitle: Text('Tổng tiền: ${bill.totalAmount} VND'),
//             trailing: Text(bill.dateIssued.toString().split(' ')[0]),
//             onTap: () {
//               // Điều hướng đến chi tiết hóa đơn (nếu cần)
//             },
//           );
//         },
//       ),
//     );
//   }
// }
