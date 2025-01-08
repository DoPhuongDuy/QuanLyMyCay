import 'dart:convert';
import 'package:http/http.dart' as http;
import '/Test/service.dart';
import '../api_endpoints/api_endpoints.dart';

class RoleService {
  final Service _service = Service();

  Future<String?> getRoleByToken() async {
    // Get the token using your service
    String? token = await _service.getToken();

    // Make sure the token is not null
    if (token == null) {
      return null;
    }

    var uri = Uri.parse(ApiEndpoints.getRoleByToken);

    // Include the token in the Authorization header
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',  // Add token in the Authorization header
      },
    );

    if (response.statusCode == 200) {
      try {
        var decodedResponse = json.decode(response.body);
        return decodedResponse['role'] ?? response.body;
      } catch (e) {
        return response.body;
      }
    } else {
      throw Exception('Failed to load role');
    }
  }

}
