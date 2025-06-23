import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:insurance_app/core/errors/exceptions.dart';

/// Interface định nghĩa các phương thức lấy dữ liệu
abstract class DemoService {
  /// Nhận thông tin về người dùng giả ngẫu nhiên, bao gồm giới tính, tên, email, địa chỉ, v.v.
  Future<Map<String, dynamic>> getRandomUser();

}

/// Implementation của DemoService
class DemoServiceImp implements DemoService {
  final http.Client client;
  final String? baseUrl;

  DemoServiceImp({required this.client})
    : baseUrl = dotenv.env['DEMO_BASE_URL'];

  /// Kiểm tra cấu hình API
  void _checkApiConfig() {
    if (baseUrl == null) {
      throw const ServerException(message: 'Base URL not found');
    }
  }

  @override
  Future<Map<String, dynamic>> getRandomUser() async {
    _checkApiConfig();

    final url = '$baseUrl/api/';

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ServerException(
          message: 'Server error with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
