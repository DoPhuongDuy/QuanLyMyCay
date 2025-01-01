// import 'package:flutter/material.dart';
//
// class MenuTabBar extends StatefulWidget {
//   @override
//   _MenuTabBarState createState() => _MenuTabBarState();
// }
//
// class _MenuTabBarState extends State<MenuTabBar> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     // Tạo TabController với 4 mục
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose(); // Giải phóng TabController khi không còn sử dụng
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AppBar(
//           title: Text('Thực đơn quán'),
//           bottom: TabBar(
//             controller: _tabController,
//             tabs: [
//               Tab(text: 'Mì cay'),
//               Tab(text: 'Đồ ăn thêm'),
//               Tab(text: 'Đồ ăn nhẹ'),
//               Tab(text: 'Nước uống'),
//             ],
//           ),
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: [
//               _buildMenuTab('Mì cay'),
//               _buildMenuTab('Đồ ăn thêm'),
//               _buildMenuTab('Đồ ăn nhẹ'),
//               _buildMenuTab('Nước uống'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Hàm hiển thị nội dung của từng tab
//   Widget _buildMenuTab(String title) {
//     return Center(
//       child: Text(
//         'Danh sách $title', // Hiển thị danh sách món ăn cho từng mục
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
