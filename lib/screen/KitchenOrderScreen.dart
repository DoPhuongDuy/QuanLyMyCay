import 'package:damh4/screen/Custom/CustomAppBar.dart';
import 'package:flutter/material.dart';
import '../Test/OrderService.dart';
import '../model/Order.dart';
import '../model/OrderDetail.dart';

class KitchenOrderScreen extends StatefulWidget {
  const KitchenOrderScreen({super.key, required this.title});

  final String title;

  @override
  State<KitchenOrderScreen> createState() => _KitchenOrderScreenState();
}

class _KitchenOrderScreenState extends State<KitchenOrderScreen> {
  // Sample orders data (replace with API or database data in real use case)
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Load orders on screen load
  }

  // Simulated fetch orders function (replace with real API call)
  void _fetchOrders() async {
    try {
      List<Order> _orders = await OrderService().getAllActiveOrders(); // Gọi service lấy orders
      setState(() {
        orders = _orders; // Cập nhật state với danh sách orders
      });
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bếp - Danh sách Đơn hàng',
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          Order order = orders[index];
          return _buildOrderCard(order);
        },
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text('Mã hóa đơn: ${order.invoice}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tổng tiền: \$${order.totalMoney}'),
            Text('Ghi chú: ${order.note}'),
            Text('Trạng thái: ${order.isActive ? "Đang xử lý" : "Đã hoàn thành"}'),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.blue,
        ),
        onTap: () {
          // Navigate to a detailed page or show the order details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailScreen(order: order),
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết Đơn hàng ${order.invoice}'),
      ),
      body: ListView.builder(
        itemCount: order.orderDetails.length,
        itemBuilder: (context, index) {
          OrderDetail orderDetail = order.orderDetails[index];
          return _buildOrderDetailCard(orderDetail);
        },
      ),
    );
  }

  Widget _buildOrderDetailCard(OrderDetail orderDetail) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(orderDetail.product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Số lượng: ${orderDetail.numberOfProducts}'),
            Text('Cấp độ: ${orderDetail.spiceLevel}'),
            Text('Ghi chú: ${orderDetail.note}'),
          ],
        ),
      ),
    );
  }
}
