import 'package:insurance_app/services/demo_service.dart';
import 'package:insurance_app/src/models/random_user_response.dart';

/// Interface định nghĩa các phương thức lấy dữ liệu từ repository
abstract class DemoRepository {
  /// Nhận thông tin về người dùng giả ngẫu nhiên, bao gồm giới tính, tên, email, địa chỉ, v.v.
  Future<RandomUserResponse> getRandomUser();

}

/// Implementation của DemoRepository
class DemoRepositoryImp implements DemoRepository {
  final DemoService weatherService;

  DemoRepositoryImp({required this.weatherService});

  @override
  Future<RandomUserResponse> getRandomUser() async {
    try {
      final jsonData = await weatherService.getRandomUser();
      return RandomUserResponse.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }

}
