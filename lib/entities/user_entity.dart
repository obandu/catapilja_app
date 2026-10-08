part of catapiljaapp;

class UserEntity {
  final String userId;
  final String username;
  final String emailAddress;
  final bool totpEnabled;
  final bool isActive;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime? lastLoginAt;
  final DateTime? passwordDate;

  UserEntity({
    required this.userId,
    required this.username,
    required this.emailAddress,
    required this.totpEnabled,
    required this.isActive,
    required this.createdAt,
    required this.modifiedAt,
    this.lastLoginAt,
    this.passwordDate,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    final String lastLoginTime = map['last_login_at'].toString().trim();
    final String passwordDateTime = map['password_date'].toString().trim();
    return UserEntity(
      userId: map['user_id'] as String,
      username: map['username'] as String,
      emailAddress: map['email_address'] as String,
      totpEnabled: map['totp_enabled'] as bool,
      isActive: map['is_active'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
      modifiedAt: DateTime.parse(map['modified_at'] as String),
      lastLoginAt: (lastLoginTime == "null" || lastLoginTime == "NEVER")
          ? null
          : DateTime.parse(lastLoginTime),
      passwordDate: (passwordDateTime == "null" || passwordDateTime == "NEVER")
          ? null
          : DateTime.parse(passwordDateTime),
    );
  }

  UserEntity copyWith({
    String? userId,
    String? username,
    String? emailAddress,
    bool? totpEnabled,
    bool? isActive,
    DateTime? createdAt,
    DateTime? modifiedAt,
    DateTime? lastLoginAt,
    DateTime? passwordDate,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      emailAddress: emailAddress ?? this.emailAddress,
      totpEnabled: totpEnabled ?? this.totpEnabled,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      passwordDate: passwordDate ?? this.passwordDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'email_address': emailAddress,
      'totp_enabled': totpEnabled,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'modified_at': modifiedAt.toIso8601String(),
      'last_login_at': lastLoginAt?.toIso8601String(),
      'password_date': passwordDate?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() => username;

  String bigView() {
    return "ID: $userId\nUser: $username\nEmail: $emailAddress";
  }
}
