  import 'dart:async';
import 'dart:convert';
import 'package:damh4/model/RegisterDTO.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../api_endpoints/api_endpoints.dart';
import '../model/Login.dart';

class Service {
  Future<String> saveUser(RegisterDTO registerDTO) async {
    var uri = Uri.parse(ApiEndpoints.register);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = json.encode(registerDTO);

    try {
      var response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Trả về thông báo thành công khi status code là 200
        return 'Đăng ký thành công!';
      } else {
        // Trả về thông báo lỗi từ phản hồi nếu status code không phải là 200
        var responseJson = json.decode(response.body);
        return responseJson['message'] ?? 'Có lỗi xảy ra';
      }
    } catch (e) {
      print("Error occurred while saving user: $e");
      return 'Lỗi kết nối với máy chủ';
    }
  }


  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);  // Lưu token vào Secure Storage
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');  // Đọc token từ Secure Storage
  }
  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
  }

  //login
  Future<String> loginUser(Login login) async {
    var uri = Uri.parse(ApiEndpoints.login);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = json.encode(login.toJson()); // Chuyển Login thành JSON

    try {
      var response = await http.post(uri, headers: headers, body: body);

      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Lưu token vào Secure Storage nếu đăng nhập thành công
        String token = response.body;  // Giả sử token được trả về từ body của response
        await saveToken(token);
        return 'Đăng nhập thành công';
      } else {
        if(response.statusCode == 403){
          return 'Sai mật khẩu hoặc tài khoản';
        }
        return 'Lỗi: ${response.body}';
      }
    } catch (e) {
      print("Error occurred while logging in: $e");
      return 'Lỗi kết nối';
    }
  }


}
