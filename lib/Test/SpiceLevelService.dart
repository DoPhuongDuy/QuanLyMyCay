import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/SpiceLevel.dart';

class SpiceLevelService {
  static const String apiUrl = 'http://localhost:8080/api/v1/spice-levels/get-all';

  // Gọi API để lấy danh sách SpiceLevel
  static Future<List<SpiceLevel>> fetchSpiceLevels() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Chuyển đổi danh sách JSON thành danh sách SpiceLevel
        return data.map((item) => SpiceLevel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load spice levels. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching spice levels: $e');
    }
  }
}