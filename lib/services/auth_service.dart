import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:insurance_app/core/errors/exceptions.dart';

abstract class AuthService {
  Future<Map<String, dynamic>> login({required String email, required String password, required bool rememberMe});
}

class AuthServiceImp implements AuthService {
  final http.Client client;
  final String? baseUrl;

  AuthServiceImp({required this.client})
      : baseUrl = dotenv.env['AUTH_BASE_URL'];

  /// Kiểm tra cấu hình API
  void _checkApiConfig() {
    if (baseUrl == null) {
      throw const ServerException(message: 'Base URL not found');
    }
  }

  @override
  Future<Map<String, dynamic>> login({required String email, required String password, required bool rememberMe}) async {
    _checkApiConfig();

    final url = '$baseUrl/v1/login/login';

    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'remember_me': rememberMe,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Đăng nhập thất bại: ${response.body}');
    }
  }

}
