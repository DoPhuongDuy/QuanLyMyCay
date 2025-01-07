import 'package:flutter/material.dart';
import 'screens/kitchen_page.dart'; // Import Kitchen Page
import 'screens/stall_page.dart';   // Import Stall Page

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0; // 0 for Stall Page, 1 for Kitchen Page

  // List of pages to navigate between
  final List<Widget> _pages = [
    StallScreen(), // Quầy
    KitchenScreen(), // Bếp
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel'),
          backgroundColor: Color(0xFFb30000),
          actions: [
            // Navigate to Stall Page
            TextButton(
              onPressed: () {
                if (_currentIndex != 0) {
                  _onItemTapped(0); // Switch to Stall Page
                }
              },
              child: Text(
                'Quầy',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Navigate to Kitchen Page
            TextButton(
              onPressed: () {
                if (_currentIndex != 1) {
                  _onItemTapped(1); // Switch to Kitchen Page
                }
              },
              child: Text(
                'Bếp',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: _pages[_currentIndex], // Display the current page
      ),
    );
  }
}
