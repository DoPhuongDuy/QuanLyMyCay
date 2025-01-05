import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/order_service.dart';
import '../models/orderitem.dart';
import '../widgets/food_tile.dart';
import '../widgets/custom_appbar.dart'; // Import CustomAppBar
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late Future<List<Food>> foodItems;
  List<OrderItem> cartItems = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    foodItems = OrderService().getFoodItems();
    _tabController = TabController(length: 4, vsync: this); // Tạo TabController với 4 tab
  }

  void addToCart(Food food) {
    setState(() {
      cartItems.add(OrderItem(id: food.id, name: food.name, quantity: 1, price: food.price, image: food.image));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Đặt Món'),
      body: Container(
        color: Color(0xFFF5F5F5), // Màu nền xám nhạt
        child: Column(
          children: [
            // TabBar
            TabBar(
              controller: _tabController,
              labelColor: Color(0xFFDF3E12), // Màu chữ của tab
              unselectedLabelColor: Color(0xFF1A1A1A), // Màu chữ khi chưa chọn
              tabs: [
                Tab(text: 'Mì cay'),
                Tab(text: 'Đồ ăn thêm'),
                Tab(text: 'Đồ ăn nhẹ'),
                Tab(text: 'Nước uống'),
              ],
            ),
            // Nội dung của TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMenuTab('Mì cay'),
                  _buildMenuTab('Đồ ăn thêm'),
                  _buildMenuTab('Đồ ăn nhẹ'),
                  _buildMenuTab('Nước uống'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFDF3E12),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30,
                    ),
                    if (cartItems.isNotEmpty)  // Chỉ hiển thị số lượng nếu có sản phẩm trong giỏ hàng
                      Positioned(
                        right: -10,
                        top: -10,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Text(
                            '${cartItems.length}',  // Hiển thị số lượng sản phẩm trong giỏ
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CartDetailsPage(cartItems: cartItems),  // Hiển thị giỏ hàng với dữ liệu mới
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (cartItems.isNotEmpty) {
                    print("Đặt món thành công");
                  }
                },
                child: Text('Đặt món'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm hiển thị nội dung của từng tab
  Widget _buildMenuTab(String title) {
    return FutureBuilder<List<Food>>(
      future: foodItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi khi tải món ăn'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Không có món ăn nào'));
        } else {
          final foods = snapshot.data!;
          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return FoodTile(
                food: foods[index],
                addToCart: addToCart,
              );
            },
          );
        }
      },
    );
  }
}
