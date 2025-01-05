class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';
  static const String register = '$baseUrl/users/register';
  static const String login = '$baseUrl/users/login';
  static const String getAllCategories = '$baseUrl/categories/get-all';
  static const String getAllProducts = '$baseUrl/products/get-all';
}
