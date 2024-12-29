// import 'package:flutter/material.dart';
// import 'package:damh_flutter/models/table.dart';
//
// class TableManagementPage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quản Lý Bàn'),
//       ),
//       body: ListView.builder(
//         itemCount: tables.length,
//         itemBuilder: (context, index) {
//           final table = tables[index];
//           return ListTile(
//             title: Text(table.name),
//             subtitle: Text('Sức chứa: ${table.capacity} người'),
//             trailing: Icon(
//               table.isOccupied ? Icons.check_circle : Icons.cancel,
//               color: table.isOccupied ? Colors.green : Colors.red,
//             ),
//             onTap: () {
//               // Điều hướng đến chi tiết bàn (nếu cần)
//             },
//           );
//         },
//       ),
//     );
//   }
// }
