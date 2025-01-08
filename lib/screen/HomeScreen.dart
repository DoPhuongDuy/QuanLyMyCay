  import 'package:damh4/model/Order.dart';
  import 'package:damh4/model/OrderDetail.dart';
  import 'package:damh4/screen/Custom/CustomAppBar.dart';
  import 'package:flutter/material.dart';
  import '../Test/CheckToken.dart';
  import '../Test/CategoryService.dart';
  import '../Test/OrderService.dart';
import '../Test/ProductService.dart';
  import '../api_endpoints/api_endpoints.dart';
  import '../model/Product.dart';
  import '/Test/service.dart'; // Thêm import Service
  import '/model/Category.dart';
import 'NoteScreen.dart';
import 'OrderScreen.dart'; // Thêm import CategoryService
  
  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key, required this.title});
  
    final String title;
  
    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }
  
  class _HomeScreenState extends State<HomeScreen> {
    final CategoryService _categoryService = CategoryService();
    final CheckToken _checkToken = CheckToken(); // Khởi tạo _checkToken
    final ProductService _productService = ProductService(); // Khởi tạo ProductService
    final Service _service = Service(); // Khởi tạo đối tượng Service
    bool isLoading = true; // Biến để theo dõi trạng thái tải dữ liệu
    List<Category> categories = []; // Danh sách lưu các Category
    Map<int, List<Product>> categoryProducts = {}; // Lưu trữ sản phẩm theo mỗi category
    Order order = Order(
      id: 0,
      invoice: 'unname',
      totalMoney: 0,
      note: '',
      isActive: true,
      orderDetails: [],
    );
    int? selectedLevel;
    @override
    void initState() {
      super.initState();
      fetchData();
    }
  
    // Lấy dữ liệu từ API và gọi fetchProductsForCategory
    Future<void> fetchData() async {
      try {
        // Lấy danh sách các danh mục
        List<Category> result = await _categoryService.fetchCategories();
        // Lấy sản phẩm cho từng danh mục
        for (var category in result) {
          await fetchProductsForCategory(category.id);
        }
  
        setState(() {
          categories = result;
          isLoading = false; // Dừng trạng thái tải dữ liệu
        });
      } catch (e) {
        if (e.toString() == 'Unauthorized') {
          // Nếu bị Unauthorized, đăng xuất và quay lại trang login
          await _checkToken.logout(context);
        } else {
          // Xử lý các lỗi khác
          print('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An error occurred')),
          );
        }
      }
    }
  
    // Lấy sản phẩm cho một danh mục
    Future<void> fetchProductsForCategory(int categoryId) async {
      try {
        List<Product> products = await _productService.fetchProductsByCategory(categoryId);
        setState(() {
          categoryProducts[categoryId] = products; // Lưu trữ sản phẩm vào map
        });
      } catch (e) {
        print('Error fetching products for category $categoryId: $e');
      }
    }
    // Hàm thêm sản phẩm vào giỏ hàng
    void addToCart(Product product) {
      setState(() {
        bool isProductExist = false;
        order.totalMoney += product.price;
        for (var orderDetail in order.orderDetails) {
          if (orderDetail.product.id == product.id && orderDetail.spiceLevel == orderDetail.product.SpiceLevelId) {
            // Nếu có thì tăng số lượng lên 1
            orderDetail.totalMoney += product.price;
            orderDetail.numberOfProducts += 1;
            isProductExist = true;
            return;
          }
        }
  
        // Nếu không tìm thấy sản phẩm, tạo OrderDetail mới và thêm vào danh sách
        if (!isProductExist) {
          // Tạo đối tượng OrderDetail
          OrderDetail orderDetail = OrderDetail(
            note: '',  // Hoặc lấy ghi chú từ nơi khác
            numberOfProducts: 1,
            totalMoney: product.price,
            spiceLevel: product.SpiceLevelId,
            product: product,
          );
  
          // Thêm OrderDetail vào giỏ hàng
          order.orderDetails.add(orderDetail);
        }
      });
    }
    // Hàm tính tổng tiền trong giỏ hàng
    int totalQuantity() {
      return order.orderDetails.fold(0, (sum, orderDetail) {
        return sum + orderDetail.numberOfProducts;  // Cộng dồn số lượng sản phẩm
      });
    }
    bool isModalVisible = false; // Trạng thái hiển thị modal
    bool isNoteVisible = false;
    void toggleModalVisibility() {
      setState(() {
        isModalVisible = !isModalVisible;
      });
    }
    // Hàm để xóa toàn bộ giỏ hàng (order và orderDetails)
    void clearCart() {
      order.orderDetails.clear();
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: CustomAppBar(title: widget.title),
        body: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        ) // Hiển thị vòng xoay khi dữ liệu đang tải
            : DefaultTabController(
          length: categories.length, // Số lượng tab bằng số danh mục
          child: Column(
            children: [
              // Tab Bar
              Container(
                color: const Color(0xFFF1F5F9), // Màu nền của TabBar
                child: TabBar(
                  labelColor: const Color(0xFFDF3E12),
                  unselectedLabelColor: const Color(0xFF1A1A1A), // Màu chữ khi không được chọn
                  labelStyle: const TextStyle(
                    fontSize: 13, // Cỡ chữ khi được chọn
                    fontWeight: FontWeight.w600, // Semi-bold
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 13, // Cỡ chữ khi không được chọn
                    fontWeight: FontWeight.w600, // Regular
                  ),
                  indicatorColor: const Color(0xFFDF3E12), // Màu indicator cho tab được chọn
                  tabs: categories.map((category) {
                    return Tab(text: category.name); // Tạo tab cho mỗi danh mục
                  }).toList(),
                ),
              ),
              // Tab Bar View
              Expanded(
                child: Container(
                  color: const Color(0xFFF1F5F9), // Màu nền của TabBarView
                  child: TabBarView(
                    children: categories.map((category) {
                      List<Product>? products = categoryProducts[category.id];
                      return products == null
                          ? const Center(child: Text("hiện không có sản phẩm")) // Hiển thị khi chưa tải xong
                          : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white, // Màu nền trắng cho khung sản phẩm
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    product.thumbnail != null
                                        ? Image.network(
                                      ApiEndpoints.getProductImageUrl(product.thumbnail!),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                        : const Icon(Icons.image),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Đảm bảo tên sản phẩm không cao hơn ảnh
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              product.name,
                                              style: const TextStyle(
                                                color: Color(0xFF1A1A1A),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 3), // Khoảng cách giữa tên và giá
                                          Text(
                                            '${product.description ?? 'No description available'}',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 3), // Khoảng cách giữa tên và giá
                                          Text(
                                            '${product.status == true ? 'Còn hàng' : 'Hết hàng'}',
                                            style: TextStyle(
                                              color: product.status == true ? Colors.green : Colors.red, // Xác định màu sắc
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 3), // Khoảng cách giữa tên và giá
                                          Text(
                                            '${product.price} đ',
                                            style: const TextStyle(
                                              color: Color(0xFFDF3E12), // Màu DF3E12
                                              fontSize: 16, // Cỡ chữ 16
                                              fontWeight: FontWeight.w600, // Semi-bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0, // Khoảng cách từ trên cùng
                                  right: 15, // Khoảng cách từ bên phải
                                  child: (category.id == 1 || category.id == 2)
                                      ? DropdownButton<int>(
                                    value: product.SpiceLevelId,  // Sử dụng selectedLevel để gán giá trị hiện tại
                                    items: List.generate(
                                      8,
                                          (index) => DropdownMenuItem(
                                        value: index ,
                                        child: Text('Cấp độ ${index}'),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        product.SpiceLevelId = value;
                                      });
                                      // Xử lý logic khi chọn cấp độ
                                    },
                                    hint: Center(
                                      child: const Text(
                                        'Cấp độ',
                                        style: TextStyle(
                                          fontSize: 12, // Kích thước chữ
                                          color: Colors.black, // Màu chữ
                                          fontWeight: FontWeight.w400, // Semi-bold
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 12, // Kích thước chữ
                                      color: Colors.black, // Màu chữ
                                      fontWeight: FontWeight.w400, // Semi-bold
                                    ),

                                    dropdownColor: Colors.white, // Màu nền menu dropdown
                                  )
                                      : const SizedBox.shrink(), // Widget trống nếu điều kiện không thỏa mãn
                                ),
                                // Nút dấu cộng ở góc phải bên dưới
                                Positioned(
                                  bottom: 15,
                                  right: 15,
                                  child: GestureDetector(
                                    onTap: () => addToCart(product), // Thêm sản phẩm vào giỏ hàng
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFDF3E12), // Màu nút DF3E12
                                        borderRadius: BorderRadius.circular(5), // Bo góc (giữ hình vuông)
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 16, // Kích thước dấu cộng
                                          color: Colors.white, // Màu của dấu cộng
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Giỏ hàng
              // Kiểm tra nếu giỏ hàng không rỗng
              if (isModalVisible)
                Positioned(
                  bottom: 60, // Đặt modal dưới giỏ hàng
                  left: 0,
                  right: 0,
                  child: Material(
                    color: Colors.transparent, // Làm nền trong suốt
                    child: SizedBox(
                      height: 400,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // "Xóa Tất Cả" button
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        // Clear the order details and reset total money
                                        clearCart();
                                        order.totalMoney = 0;
                                        isModalVisible = false;
                                      });
                                    },
                                    child: Text(
                                      'Xóa Tất Cả',
                                      style: TextStyle(
                                        color: Color(0xFFDF3E12), // Màu chữ
                                        fontSize: 12, // Cỡ chữ
                                        fontWeight: FontWeight.w600, // Semi Bold
                                      ),
                                    ),
                                  ),
                                  // "Giỏ Hàng" title
                                  Text(
                                    "Giỏ Hàng",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Close button
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        isModalVisible = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: order.orderDetails.length,
                                itemBuilder: (context, index) {
                                  final orderDetail = order.orderDetails[index];
                                  return ListTile(
                                    leading: orderDetail.product.thumbnail != null
                                        ? Image.network(
                                      ApiEndpoints.getProductImageUrl(orderDetail.product.thumbnail!),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ) // Hình ảnh sản phẩm
                                        : Icon(Icons.image, size: 50), // Nếu không có hình ảnh, hiển thị icon mặc định
                                    title: Text(
                                      orderDetail.product.name,
                                      style: TextStyle(
                                        color: Colors.black, // Màu chữ đen
                                        fontSize: 14, // Cỡ chữ 12
                                        fontWeight: FontWeight.w600, // Semi-bold
                                      ),
                                    ), // Hiển thị tên sản phẩm từ orderDetail
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Khi người dùng tap vào "Ghi chú", chuyển tới NoteScreen
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => NoteScreen(
                                                  initialNote: orderDetail.note ?? '', // Truyền ghi chú hiện tại vào màn hình ghi chú
                                                  onNoteSaved: (newNote) {
                                                    setState(() {
                                                      orderDetail.note = newNote; // Cập nhật ghi chú mới vào orderDetail
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            orderDetail.note?.isNotEmpty ?? false ? orderDetail.note! : 'Thêm ghi chú',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFC2C2C2)
                                            ),
                                            overflow: TextOverflow.ellipsis, // Thêm ba chấm nếu văn bản quá dài
                                            maxLines: 1, // Giới hạn chỉ hiển thị 1 dòng
                                          ),
                                        ),
                                        SizedBox(height: 8), // Thêm khoảng cách giữa ghi chú và giá
                                        Text(
                                          '${orderDetail.product.price}đ',
                                          style: TextStyle(
                                            color: Color(0xFFDF3E12), // Màu chữ #DF3E12
                                            fontSize: 14, // Cỡ chữ 14
                                            fontWeight: FontWeight.w600, // Semi-bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min, // Để các nút không chiếm hết không gian
                                      children: [
                                        if (orderDetail.product.category.id == 1 || orderDetail.product.category.id == 2)
                                          Text(
                                            'Cấp độ: ${orderDetail.spiceLevel ?? 0}  ',
                                            style: TextStyle(
                                              color: Colors.black, // Màu chữ đen
                                              fontSize: 12, // Cỡ chữ 12
                                              fontWeight: FontWeight.w600, // Medium (fontWeight w500 cho medium)
                                            ),
                                          ),
                                        IconButton(
                                          icon: Icon(Icons.remove_circle_outline_outlined, color: Colors.grey), // Nút trừ
                                          onPressed: () {
                                            setState(() {
                                              if (orderDetail.numberOfProducts > 1) {
                                                orderDetail.numberOfProducts--; // Giảm số lượng sản phẩm
                                                order.totalMoney -= orderDetail.product.price;
                                              } else {
                                                // Xóa orderDetail khi số lượng là 0
                                                order.orderDetails.removeAt(index); // Loại bỏ orderDetail khỏi danh sách
                                                order.totalMoney -= orderDetail.product.price; // Cập nhật tổng tiền
                                                isModalVisible = false;
                                              }
                                            });
                                          },
                                        ),
                                        Text('x${orderDetail.numberOfProducts}',
                                          style: TextStyle(
                                            color: Colors.black, // Màu chữ đen
                                            fontSize: 14, // Cỡ chữ 12
                                            fontWeight: FontWeight.w600, // Medium (fontWeight w500 cho medium)
                                          )
                                        ), // Hiển thị số lượng sản phẩm
                                        IconButton(
                                  icon: Icon(Icons.add_circle_outline_outlined, color: Color(0xFFDF3E12)), // Nút cộng
                                          onPressed: () {
                                            setState(() {
                                              orderDetail.numberOfProducts++; // Tăng số lượng sản phẩm
                                              order.totalMoney += orderDetail.product.price;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),



              if (order.orderDetails.isNotEmpty) ...[
                Row(
                  children: [
                    // Phần 1: Giỏ hàng
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          toggleModalVisibility(); // Call function passed via onCartTap
                        },
                        child: Container(
                          height: 60,
                          color: Colors.white, // Màu giỏ hàng
                          child: Center(
                            child: Stack(
                              alignment: Alignment.topRight, // Đặt Text ở góc trên bên phải
                              clipBehavior: Clip.none,
                              children: [
                                // Tạo một container trống để tạo khoảng cách và không có màu nền
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent, // Không có màu nền
                                  ),
                                ),
                                // Biểu tượng giỏ hàng
                                Positioned(
                                  right: 0, // Di chuyển biểu tượng giỏ hàng sang phải
                                  top: -10, // Di chuyển biểu tượng lên trên
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                ),
                                // Số lượng sản phẩm trong giỏ hàng
                                Positioned(
                                  left: 15,
                                  bottom: 22,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      '${totalQuantity()}', // Hiển thị số lượng sản phẩm
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Phần 2: Tổng tiền
                    Expanded(
                      child: Container(
                        height: 60,
                        color: Colors.white, // Màu nền của phần 2
                        child: Column(  // Căn giữa nội dung
                          mainAxisAlignment: MainAxisAlignment.center,  // Căn giữa theo chiều dọc
                          crossAxisAlignment: CrossAxisAlignment.center,  // Căn giữa theo chiều ngang
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${order.totalMoney} đ  ', // Hiển thị tổng tiền
                                style: const TextStyle(
                                  fontSize: 20,  // Cỡ chữ là 20
                                  fontWeight: FontWeight.w600,  // Medium font weight
                                  color: Color(0xFFDF3E12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Phần 3: Đặt món
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFAE0007), Color(0xFFDF3E12)], // Màu chuyển từ AE0007 sang DF3E12
                            begin: Alignment.topCenter,  // Bắt đầu từ trên
                            end: Alignment.bottomCenter, // Kết thúc ở dưới
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,  // Đặt khung ở giữa
                          child: GestureDetector(
                            onTap: () async {
                              // Gọi service để tạo đơn hàng
                              OrderService orderService = OrderService();
                              bool success = await orderService.createOrder(order);  // Gọi service với đối tượng order

                              if (success) {
                                // Hiển thị thông báo tạo đơn hàng thành công
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order created successfully')));

                                // Sau khi tạo đơn hàng thành công, chuyển đến OrderScreen
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderScreen(order: order),
                                  ),
                                );

                                // Xóa order sau khi quay lại từ OrderScreen
                                setState(() {
                                  clearCart(); // Gán null để xóa order
                                });
                              } else {
                                // Hiển thị thông báo khi tạo đơn hàng thất bại
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create order')));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Tạo khoảng cách xung quanh text
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Đặt màu trong suốt cho Container chứa text
                              ),
                              child: const Text(
                                'Đặt món',
                                style: TextStyle(
                                  fontSize: 20,  // Cỡ chữ là 20
                                  fontWeight: FontWeight.w600,  // Semi-bold font weight
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    }
  }
