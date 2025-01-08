import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_endpoints/api_endpoints.dart';
import '../model/Category.dart';

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    var uri = Uri.parse(ApiEndpoints.getAllCategories);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
