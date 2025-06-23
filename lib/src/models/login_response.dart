class LoginResponse {
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final int? expiresIn;
  final Map<String, dynamic>? user;

  LoginResponse({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return LoginResponse(
      accessToken: data['access_token'],
      refreshToken: data['refresh_token'],
      tokenType: data['token_type'],
      expiresIn: data['expires_in'],
      user: data['user'] ?? {},
    );
  }
}
