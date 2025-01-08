import 'package:flutter/material.dart';
import 'package:damh4/Test/RoleService.dart';
import 'package:damh4/model/Login.dart';
import 'package:damh4/Test/service.dart';
import 'Custom/CustomAppBar.dart';
import '../screen/Custom/CustomClipper.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key, required this.title});

  final String title;

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final RoleService _roleService = RoleService();
  Service service = Service();

  String errorMessage = '';
  String adminGreeting = "Chào mừng, Admin!";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevents back navigation
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Admin Dashboard'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.7,
                width: double.infinity,
                child: _buildAdminDashboard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminDashboard() {
    return ClipPath(
      clipper: CustomClipperWidget(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFDF3E12),
              Color(0xFFAE0001),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                adminGreeting,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 60),
              _buildDashboardOption('User Management', Icons.people, () {
                // Navigate to user management
                Navigator.pushNamed(context, '/user_management');
              }),
              const SizedBox(height: 20),
              _buildDashboardOption('Settings', Icons.settings, () {
                // Navigate to settings screen
                Navigator.pushNamed(context, '/settings');
              }),
              const SizedBox(height: 20),
              _buildDashboardOption('Reports', Icons.bar_chart, () {
                // Navigate to reports screen
                Navigator.pushNamed(context, '/reports');
              }),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Đăng xuất",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardOption(String title, IconData icon, VoidCallback onTap) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.white),
        onTap: onTap,
      ),
    );
  }

  void _logout() async {
    // Handle logout logic
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã đăng xuất')));
    Navigator.pushReplacementNamed(context, '/login');
  }
}
