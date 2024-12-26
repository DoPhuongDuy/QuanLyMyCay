import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, Map<String, dynamic>> cart = {};  // Giỏ hàng lưu trữ thông tin chi tiết của món ăn

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4 tab cho 4 mục
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
          buildMenuList('Mỳ cay'),
          buildMenuList('Đồ ăn thêm'),
          buildMenuList('Đồ ăn nhẹ'),
          buildMenuList('Nước uống'),
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
                onPressed: cart.isEmpty ? null : () {},  // Nút đặt món chỉ hoạt động khi có món
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

  Widget buildMenuList(String category) {
    List<Map<String, String>> menuItems = [];
    if (category == 'Mỳ cay') {
      menuItems = [
        {
          'title': 'Mì cay hải sản',
          'description': 'Có các thành phần xúc xích, cá viên, tôm, mực',
          'price': '35.000đ',
          'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnlui3ef1Vy88V1A4lHVvmZvIXZDayyC32Ug&s',
        },
        {
          'title': 'Mì cay bò Waygu',
          'description': 'Có các thành phần xúc xích, thịt bò, bò viên, cá viên',
          'price': '40.000đ',
          'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnlui3ef1Vy88V1A4lHVvmZvIXZDayyC32Ug&s',
        },
        {
          'title': 'Mì cay đùi gà',
          'description': 'Có các thành phần xúc xích, cá viên, đùi gà xé',
          'price': '35.000đ',
          'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnlui3ef1Vy88V1A4lHVvmZvIXZDayyC32Ug&s',
        },
        {
          'title': 'Mì cay bò Úc',
          'description': 'Có các thành phần xúc xích, thịt bò, bò viên',
          'price': '35.000đ',
          'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnlui3ef1Vy88V1A4lHVvmZvIXZDayyC32Ug&s',
        },
      ];
    } else if (category == 'Đồ ăn thêm') {
      menuItems = [
        {
          'title': 'Cá viên luộc',
          'description': 'Cá viên được luộc sẵn, gồm 5 viên',
          'price': '12.000đ',
          'imageUrl': 'https://cdn.tgdd.vn//News/1534757//ca-vien-chien-bao-nhieu-calo-cach-an-ca-vien-13-800x450.jpg',
        },
        {
          'title': 'Cá viên chiên',
          'description': 'Cá viên được chiên lên, gồm 5 viên',
          'price': '14.000đ',
          'imageUrl': 'https://cdn.tgdd.vn//News/1534757//ca-vien-chien-bao-nhieu-calo-cach-an-ca-vien-13-800x450.jpg',
        },
        {
          'title': 'Bò viên luộc',
          'description': 'Bò viên được luộc lên, gồm 5 viên',
          'price': '12.000đ',
          'imageUrl': 'https://cdn.tgdd.vn//News/1534757//ca-vien-chien-bao-nhieu-calo-cach-an-ca-vien-13-800x450.jpg',
        },
        {
          'title': 'Bò viên chiên',
          'description': 'Bò viên được chiên lên, gồm 5 viên',
          'price': '14.000đ',
          'imageUrl': 'https://cdn.tgdd.vn//News/1534757//ca-vien-chien-bao-nhieu-calo-cach-an-ca-vien-13-800x450.jpg',
        },
      ];
    } else if (category == 'Đồ ăn nhẹ') {
      menuItems = [
        {
          'title': 'Khoai tây chiên',
          'description': 'Khoai tây chiên giòn, thơm ngon',
          'sales': '200 đã bán',
          'price': '15.000đ',
          'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnoAtzQ_kRSfrB6tso2cYNrUuaPmjOLJXSRQ&s',
        },
        {
          'title': 'Gà rán',
          'description': 'Gà rán giòn rụm, ngọt thịt',
          'sales': '180 đã bán',
          'price': '30.000đ',
          'imageUrl': 'https://product.hstatic.net/200000605103/product/dui-ga-gion_b57cd7734a324493aa2df6ba941929eb_master.png',
        },
      ];
    } else if (category == 'Nước uống') {
      menuItems = [
        {
          'title': 'Nước ngọt',
          'description': 'Nước ngọt mát lạnh',
          'price': '12.000đ',
          'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9tetX7bM-KFfBHsEBjahr2a3m9PfzOtRYPQ&s',
        },
        {
          'title': 'Trà sữa',
          'description': 'Trà sữa thơm ngon',
          'price': '25.000đ',
          'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLro0x-F5aknipUJxYv9cE3eOuctbuk6-Ymw&s',
        },
      ];
    }

    return ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        var item = menuItems[index];
        return menuItem(item['title']!, item['description']!, item['price']!, item['imageUrl']!, category);
      },
    );
  }

  Widget menuItem(String title, String description, String price, String imageUrl, String category) {
    int spiceLevel = cart[title]?['spiceLevel'] ?? 1; // Sử dụng giá trị spiceLevel từ giỏ hàng hoặc mặc định là 1
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
            // Hiển thị ảnh món ăn
            Image.network(
              imageUrl,
              width: 80,
              height: 80,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(description, style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(price, style: TextStyle(fontSize: 16, color: Color(0xFFD32F2F), fontWeight: FontWeight.bold)),
                  if (category == 'Mỳ cay') // Chỉ hiển thị cho Mỳ cay
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(7, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              spiceLevel = index + 1;
                              // Cập nhật spiceLevel trong giỏ hàng
                              if (cart.containsKey(title)) {
                                cart[title]!['spiceLevel'] = spiceLevel;
                              } else {
                                // Nếu món ăn này không có trong giỏ hàng, thêm vào với số lượng ban đầu là 0 và cấp độ cay đã chọn
                                cart[title] = {
                                  'quantity': 0,
                                  'spiceLevel': spiceLevel,
                                  'imageUrl': imageUrl,
                                  'description': description
                                };
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: spiceLevel == (index + 1) ? Colors.red : Colors.grey,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                if (cart.containsKey(title) && cart[title]!['quantity'] > 0)
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        if (cart.containsKey(title) && cart[title]!['quantity'] > 0) {
                          cart[title]!['quantity'] = cart[title]!['quantity'] - 1;
                        }
                        // Nếu số lượng là 0, xóa món khỏi giỏ hàng
                        if (cart[title]!['quantity'] == 0) {
                          cart.remove(title);
                        }
                      });
                    },
                    color: Color(0xFFD32F2F),
                    iconSize: 30,
                  ),
                Text(cart.containsKey(title) ? cart[title]!['quantity'].toString() : "0", style: TextStyle(color: Color(0xFFD32F2F))),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      if (cart.containsKey(title)) {
                        cart[title]!['quantity'] = cart[title]!['quantity'] + 1;
                      } else {
                        cart[title] = {
                          'quantity': 1,
                          'imageUrl': imageUrl,
                          'description': description,
                          'spiceLevel': spiceLevel,
                        };
                      }
                    });
                  },
                  color: Color(0xFFD32F2F),
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Tính tổng giá trị giỏ hàng
  String getTotalPrice() {
    int total = 0;
    cart.forEach((title, value) {
      int price = 35000; // Bạn có thể thay đổi giá món ăn tương ứng
      total += price * (value['quantity'] as int);
    });
    return total.toString();
  }

  // Hiển thị giỏ hàng
  void showCart() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Giỏ hàng'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cart.entries.map((entry) {
                var item = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Image.network(
                        item["imageUrl"],
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.key, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(item['description'], style: TextStyle(fontSize: 14, color: Colors.grey)),
                            Text('Số lượng: ${item['quantity']}', style: TextStyle(fontSize: 14)),
                            if (entry.key.contains('Mì cay')) // Chỉ hiển thị cấp độ cay nếu món là mì cay
                              Text('Cấp độ cay: ${item['spiceLevel']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}