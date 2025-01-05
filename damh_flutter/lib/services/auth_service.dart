import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // URL của API
  final String apiUrl = 'https://my-json-server.typicode.com/TylerTuanPhan/LapTrinhDiDong/users';

  // Hàm đăng nhập
  Future<bool> login(String username, String password) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);

      final user = users.firstWhere(
            (user) => user['username'] == username && user['password'] == password,
        orElse: () => {},
      );

      return user.isNotEmpty;
    } else {
      throw Exception('Lỗi kết nối đến API');
    }
  }

  // Hàm đăng ký
  Future<bool> register(String username, String password) async {
    final response = await http.get(Uri.parse(apiUrl)); // Lấy danh sách người dùng hiện tại

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);

      // Kiểm tra xem người dùng đã tồn tại chưa
      final existingUser = users.firstWhere(
            (user) => user['username'] == username,
        orElse: () => {},
      );

      if (existingUser.isNotEmpty) {
        return false; // Nếu tên người dùng đã tồn tại
      }

      // Nếu chưa có người dùng, tiến hành thêm người dùng mới
      final newUser = {
        'id': users.length + 1, // Tạo ID mới
        'username': username,
        'password': password,
      };

      // Thêm người dùng mới vào API
      final addUserResponse = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newUser),
      );

      return addUserResponse.statusCode == 201; // Nếu thêm thành công, trả về true
    } else {
      throw Exception('Lỗi kết nối đến API');
    }
  }
}
