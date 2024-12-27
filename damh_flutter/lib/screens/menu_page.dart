import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/api_client.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<MenuItem>> menuItems;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4 tab cho 4 mục
    menuItems = APIClient().fetchMenuByCategory('noodle');
    menuItems = APIClient().fetchMenuByCategory('sidefood');
    menuItems = APIClient().fetchMenuByCategory('lightfood');
    menuItems = APIClient().fetchMenuByCategory('drink');// Lấy dữ liệu cho tab "Mỳ cay"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Bàn 28: Xin Chào"),
            Spacer(),
            Image.network(
              'https://www.beeart.vn/Uploads/project/20240918/e6782887-da10-4d10-9ceb-03a9283123e7.jpg',
              width: 40,
              height: 40,
            ),
          ],
        ),
        backgroundColor: Color(0xFFD32F2F),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Mỳ cay'),
            Tab(text: 'Đồ ăn thêm'),
            Tab(text: 'Đồ ăn nhẹ'),
            Tab(text: 'Nước uống'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder<List<MenuItem>>(
            future: menuItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No items available'));
              } else {
                return buildMenuList(snapshot.data!);
              }
            },
          ),
          // buildMenuList('Đồ ăn thêm'),
          // buildMenuList('Đồ ăn nhẹ'),
          // buildMenuList('Nước uống'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => showCart(),
              ),
              Spacer(),
              Text('Tổng: ${getTotalPrice()}đ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},  // Chức năng đặt món
                child: Text('Đặt Món'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD32F2F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuList(List<MenuItem> menuItems) {
    return ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        var item = menuItems[index];
        return menuItem(item.title, item.description, item.price, item.imageUrl);
      },
    );
  }

  Widget menuItem(String title, String description, String price, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.network(imageUrl, width: 80, height: 80),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(description, style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(price, style: TextStyle(fontSize: 16, color: Color(0xFFD32F2F), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTotalPrice() {
    int total = 0;
    // Giả định rằng giá của mỗi món là 35000đ, bạn có thể cập nhật lại giá theo yêu cầu
    return total.toString();
  }

  void showCart() {
    // Hiển thị giỏ hàng nếu có món
  }
}