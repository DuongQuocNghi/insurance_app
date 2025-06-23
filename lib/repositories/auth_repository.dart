import 'package:insurance_app/services/auth_service.dart';
import 'package:insurance_app/src/models/login_response.dart';

class AuthRepository {
  final AuthService service;
  AuthRepository(this.service);

  Future<LoginResponse> login(String email, String password, bool rememberMe) async {
    final response = await service.login(email: email, password: password, rememberMe: rememberMe);
    return LoginResponse.fromJson(response);
  }
}
