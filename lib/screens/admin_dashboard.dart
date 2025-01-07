import 'package:flutter/material.dart';
import 'package:demo/screens/kitchen_page.dart'; // Import kitchen screen
import 'package:demo/screens/stall_page.dart'; // Import stall screen

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  // Danh sách các trang cho việc điều hướng
  final List<Widget> _pages = [
    KitchenScreen(),  // Trang quản lý bếp
    StallScreen(),    // Trang quản lý quầy
  ];

  // Xử lý khi chọn trang
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color(0xFF800000), // Màu nền đỏ cho AppBar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF800000),
              ),
              child: Text(
                'Quản trị viên',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Quản lý Bếp'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context); // Đóng Drawer khi chọn mục
              },
            ),
            ListTile(
              title: Text('Quản lý Quầy'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context); // Đóng Drawer khi chọn mục
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],  // Hiển thị trang hiện tại
    );
  }
}
