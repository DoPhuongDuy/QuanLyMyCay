class ApiEndpoints {
  static const String baseUrl = 'http://localhost:8080/api/v1';
  static const String register = '$baseUrl/users/register';
  static const String login = '$baseUrl/users/login';
  static const String getAllCategories = '$baseUrl/categories/get-all';

  static const String getAllProducts = '$baseUrl/products/get-all';
  static const String getProductsByCategory = '$baseUrl/products/category/{id}';

  static const String createOrder = '$baseUrl/orders/create'; // Endpoint to create an order

  static const String getRoleByToken = '$baseUrl/roles/token'; // Endpoint to get role by token

  static const String getAllActiveOrders = '$baseUrl/orders/get-all-active'; // Endpoint to fetch all active orders

  static String getProductImageUrl(String imageName) {
    return '$baseUrl/products/images/$imageName';
  }
}
