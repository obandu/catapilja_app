part of catapiljaapp;

class UserRoleEntity {
  final String id;
  final String name;
  final List<UserRoleApplicationPermissionsEntity> appPermissions;

  UserRoleEntity({
    required this.id,
    required this.name,
    this.appPermissions = const [],
  });

  factory UserRoleEntity.fromMap(Map<String, dynamic> map) {
    return UserRoleEntity(
      id: map['user_role_id'] as String,
      name: map['user_role_name'] as String,
      // Maps nested appPermissions if they exist in the JSON
      appPermissions:
          (map['permissions'] as List<dynamic>?)
              ?.map(
                (e) => UserRoleApplicationPermissionsEntity.fromMap(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  // Helper method to update an application permission within this role
  UserRoleEntity copyWith({
    String? name,
    List<UserRoleApplicationPermissionsEntity>? appPermissions,
  }) {
    return UserRoleEntity(
      id: id,
      name: name ?? this.name,
      appPermissions: appPermissions ?? this.appPermissions,
    );
  }

  /// 1. Adds a new application permission to the list
  UserRoleEntity addDefinition(
    UserRoleApplicationPermissionsEntity newAppPermission,
  ) {
    if (appPermissions.contains(newAppPermission)) {
      return this;
    }

    return copyWith(appPermissions: [...appPermissions, newAppPermission]);
  }

  /// 2. Replaces an existing app permission by its ID
  UserRoleEntity updateAppPermission(
    UserRoleApplicationPermissionsEntity updatedAppPermission,
  ) {
    final updatedList = appPermissions.map((attr) {
      return attr.id == updatedAppPermission.id ? updatedAppPermission : attr;
    }).toList();

    return copyWith(appPermissions: updatedList);
  }

  /// 3. Removes an application permission by its ID
  UserRoleEntity removeAppPermission(String appPermissionId) {
    return copyWith(
      appPermissions: appPermissions
          .where((attr) => attr.id != appPermissionId)
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  /// Returns a line-separated string of all app permissions
  String getAppPermissions() {
    if (appPermissions.isEmpty) return "NO PERMISSION app Permissions";

    return appPermissions
        .map((appPermission) => appPermission.toString())
        .join('\n');
  }

  @override
  String toString() => name;

  String bigView() {
    return "$id\n$name\n${getAppPermissions()}";
  }

  // Add this method inside your UserRoleEntity class
  Map<String, dynamic> toMap() {
    return {
      'user_role_id': id,
      'user_role_name': name,
      'permissions': appPermissions.map((x) => x.toMap()).toList(),
    };
  }
}
