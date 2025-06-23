class User {
  final int id;
  final String email;
  final String name;
  final String? phone;
  final String? role;
  final String? avatar;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.role,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'],
      role: json['role'],
      avatar: json['avatar'],
    );
  }
}
