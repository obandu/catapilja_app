part of catapiljaapp;

class UserRoleAssignmentEntity {
  final String id;
  final String roleId;
  final String appModuleId;
  final String accessRight;
  final String appModuleName; // New
  final String appModuleDesc; // New

  UserRoleAssignmentEntity({
    required this.id,
    required this.roleId,
    required this.appModuleId,
    required this.accessRight,
    required this.appModuleName,
    required this.appModuleDesc,
  });

  factory UserRoleAssignmentEntity.fromMap(Map<String, dynamic> map) {
    return UserRoleAssignmentEntity(
      id: map['user_role_assignment_id'] as String,
      roleId: map['user_role_id'] as String,
      appModuleId: map['app_module_id'] as String,
      accessRight: map['access_right'] as String,
      appModuleName: map['app_module_name'] as String? ?? 'Unknown Module',
      appModuleDesc: map['app_module_desc'] as String? ?? '',
    );
  }

  UserRoleAssignmentEntity copyWith({
    String? accessRight,
    String? appModuleName,
    String? appModuleDesc,
  }) {
    return UserRoleAssignmentEntity(
      id: id,
      roleId: roleId,
      appModuleId: appModuleId,
      accessRight: accessRight ?? this.accessRight,
      appModuleName: appModuleName ?? this.appModuleName,
      appModuleDesc: appModuleDesc ?? this.appModuleDesc,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleAssignmentEntity &&
          runtimeType == other.runtimeType &&
          appModuleId == other.appModuleId;

  @override
  int get hashCode => id.hashCode;

  // Add this method inside your UserRoleAssignmentEntity class
  Map<String, dynamic> toMap() {
    return {
      'user_role_assignment_id': id,
      'user_role_id': roleId,
      'app_module_id': appModuleId,
      'access_right': accessRight,
      'app_module_name': appModuleName,
      'app_module_desc': appModuleDesc,
    };
  }

  /// Now returns a human-readable string for the UI
  @override
  String toString() {
    return "$appModuleName: $accessRight";
  }
}
