import 'package:flutter/material.dart';
import '../../model/Order.dart';

class CartWidget extends StatelessWidget {
  final Order order;
  final Function totalQuantity;
  final Function onCartTap;

  const CartWidget({
    Key? key,
    required this.order,
    required this.totalQuantity,
    required this.onCartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Phần 1: Giỏ hàng
        Expanded(
          child: GestureDetector(
            onTap: () {
              onCartTap(); // Call function passed via onCartTap
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
                onTap: () {
                  // Implement the "Đặt món" click logic here
                  print('Đặt món clicked');
                }, // Khi bấm vào "Đặt món"
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
    );
  }
}
