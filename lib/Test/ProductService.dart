import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../api_endpoints/api_endpoints.dart';
import '/model/Product.dart';

class ProductService {

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<List<Product>> fetchProductsByCategory(int  categoryId) async {
    var uri = Uri.parse(ApiEndpoints.getProductsByCategory.replaceAll('{id}', categoryId.toString()));

    String? token = await _secureStorage.read(key: 'token');

    if (token == null) {
      throw Exception('No token found');
    }

    var response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
