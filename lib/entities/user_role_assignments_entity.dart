part of catapiljaapp;

class UserRoleAssignmentEntity {
  final String id;
  final String userId;
  final String userRoleId;

  UserRoleAssignmentEntity({
    required this.id,
    required this.userId,
    required this.userRoleId,
  });

  factory UserRoleAssignmentEntity.fromMap(Map<String, dynamic> map) {
    return UserRoleAssignmentEntity(
      id: map['user_role_assignment_id'] as String,
      userId: map['user_id'] as String,
      userRoleId: map['user_role_id'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleApplicationPermissionsEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'user_role_assignment_id': id,
      'user_role_id': userRoleId,
      'user_id': userId,
    };
  }

  @override
  String toString() {
    return "$id - $userRoleId";
  }
}
