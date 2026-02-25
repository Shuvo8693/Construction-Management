// features/auth/models/user_model.dart

class UserModel {
  final int id;
  final String name;
  final String? phone;
  final String email;
  final String role;
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }
}