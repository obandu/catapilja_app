part of catapiljaapp;

class UserRoleApplicationPermissionsEntity {
  final String id;
  final String roleId;
  final String appModuleId;
  final String accessRight;
  final String appModuleName;
  final String appModuleDesc;

  UserRoleApplicationPermissionsEntity({
    required this.id,
    required this.roleId,
    required this.appModuleId,
    required this.accessRight,
    required this.appModuleName,
    required this.appModuleDesc,
  });

  factory UserRoleApplicationPermissionsEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserRoleApplicationPermissionsEntity(
      id: map['user_role_assignment_id'] as String,
      roleId: map['user_role_id'] as String,
      appModuleId: map['app_module_id'] as String,
      accessRight: map['access_right'] as String,
      appModuleName: map['app_module_name'] as String? ?? 'Unknown Module',
      appModuleDesc: map['app_module_desc'] as String? ?? '',
    );
  }

  UserRoleApplicationPermissionsEntity copyWith({
    String? accessRight,
    String? appModuleName,
    String? appModuleDesc,
  }) {
    return UserRoleApplicationPermissionsEntity(
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
      other is UserRoleApplicationPermissionsEntity &&
          runtimeType == other.runtimeType &&
          appModuleId == other.appModuleId;

  @override
  int get hashCode => id.hashCode;

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

  @override
  String toString() {
    return "$appModuleName: $accessRight";
  }
}
