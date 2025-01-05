import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_endpoints/api_endpoints.dart';
import '/model/Product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    var uri = Uri.parse(ApiEndpoints.getAllProducts);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
