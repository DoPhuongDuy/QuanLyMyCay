import 'package:flutter/material.dart';
import '../models/food.dart';
import '../services/order_service.dart';
import 'cart_page.dart';
import 'food_details_page.dart';
import '../models/orderitem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Food>> foodItems;
  List<OrderItem> cartItems = []; // Danh sách các món ăn trong giỏ hàng

  @override
  void initState() {
    super.initState();
    foodItems = OrderService().getFoodItems(); // Lấy danh sách món ăn
  }

  // Hàm thêm món ăn vào giỏ hàng
  void addToCart(OrderItem item) {
    setState(() {
      cartItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Đặt Món'),
            Spacer(),
            Image.network(
              'https://www.beeart.vn/Uploads/project/20240918/e6782887-da10-4d10-9ceb-03a9283123e7.jpg',
              width: 40,
              height: 40,
            ),
          ],
        ),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<Food>>(
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
                final food = foods[index]; // Lấy món ăn từ danh sách foods
                return ListTile(
                  title: Text(food.name),
                  subtitle: Text('${food.description}\nGiá: ${food.price} VND'),
                  leading: Image.network(food.image, width: 50, height: 50, fit: BoxFit.cover),
                  trailing: TextButton(
                    onPressed: () {
                      // Thêm món vào giỏ hàng
                      OrderItem orderItem = OrderItem(
                        id: food.id,
                        name: food.name,
                        quantity: 1, // Số lượng mặc định là 1
                        price: food.price,
                        image: food.image,
                      );
                      addToCart(orderItem);
                    },
                    child: Text(
                      'Thêm vào giỏ',
                      style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Điều hướng tới FoodDetailPage khi nhấn vào món ăn
                  // onTap: () {
                  //   // Truyền OrderItem vào FoodDetailPage thay vì food
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => FoodDetailPage(orderItem: cartItems[0]), // Truyền OrderItem vào FoodDetailPage
                  //     ),
                  //   );
                  // },
                );
              },
            );
          }
        },
      ),
      // Hiển thị giỏ hàng
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hiển thị icon giỏ hàng và mở modal khi nhấn vào
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {
                      // Mở modal giỏ hàng khi nhấn vào icon giỏ hàng
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CartDetailsPage(cartItems: cartItems); // Truyền cartItems vào modal
                        },
                      );
                    },
                  ),
                  SizedBox(width: 10),
                ],
              ),
              // Nút Đặt món
              ElevatedButton(
                onPressed: () {
                  // Xử lý đặt món, không cần điều hướng đến FoodDetailPage nữa
                  if (cartItems.isNotEmpty) {
                    // Thực hiện hành động đặt món
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
}
