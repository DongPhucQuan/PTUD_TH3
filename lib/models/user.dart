class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String role;
  final String address;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.role,
    required this.address,
    required this.createdAt,
  });

  /// Chuyển JSON từ Firebase thành object User
  factory User.fromJson(Map<String, dynamic> json, String docId) {
    return User(
      id: docId,
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      role: json['role'] ?? 'User',
      address: json['address'] ?? '',
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is String
              ? DateTime.parse(json['createdAt'])
              : DateTime.fromMillisecondsSinceEpoch(
                  json['createdAt'].seconds * 1000))
          : DateTime.now(),
    );
  }

  /// Chuyển object User thành JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'role': role,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Kiểm tra email hợp lệ
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  /// Kiểm tra số điện thoại Việt Nam (bắt đầu 0, 10-11 chữ số)
  bool isValidPhone() {
    final phoneRegex = RegExp(r'^0[0-9]{9,10}$');
    return phoneRegex.hasMatch(phone);
  }
}
