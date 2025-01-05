import 'package:damh4/screen/Custom/CustomAppBar.dart';
import 'package:flutter/material.dart';
import '../Test/CheckToken.dart';
import '../Test/CategoryService.dart';
import '/Test/service.dart'; // Thêm import Service
import '/model/Category.dart'; // Thêm import CategoryService

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryService _categoryService = CategoryService();
  final CheckToken _checkToken = CheckToken(); // Khởi tạo AuthService
  final Service _service = Service(); // Khởi tạo đối tượng Service
  bool isLoading = true; // Biến để theo dõi trạng thái tải dữ liệu
  List<Category> categories = []; // Danh sách lưu các Category

  @override
  void initState() {
    super.initState();
    _checkToken.checkToken(context, fetchData);  // Kiểm tra token và gọi fetchData
  }


  // Lấy dữ liệu từ API bảo vệ và xử lý lỗi Unauthorized
  Future<void> fetchData() async {
    try {
      // Thực hiện API call để lấy danh sách categories
      List<Category> result = await _categoryService.fetchCategories();

      // Cập nhật danh sách category vào state
      setState(() {
        categories = result;
        isLoading = false; // Đánh dấu kết thúc trạng thái tải dữ liệu
      });
    } catch (e) {
      if (e.toString() == 'Unauthorized') {
        // Nếu bị Unauthorized, xóa token và chuyển về login
        await _checkToken.logout(context);
      } else {
        // Xử lý lỗi khác
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())  // Hiển thị vòng xoay khi dữ liệu đang được tải
          : DefaultTabController(
        length: categories.length,  // Đặt số lượng tab bằng với số lượng categories
        child: Column(
          children: [
            // Tab Bar
            TabBar(
              labelColor: Color(0xFFDF3E12),  // Màu chữ cho tab
              indicatorColor: Color(0xFFDF3E12),  // Màu indicator cho tab được chọn
              tabs: categories.map((category) {
                return Tab(text: category.name);  // Tạo tab cho mỗi category
              }).toList(),
            ),
            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: categories.map((category) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(category.name), // Hiển thị tên của category
                        subtitle: Text('ID: ${category.id}'), // Hiển thị ID category (tuỳ chọn)
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
