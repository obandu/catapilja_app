part of catapiljaapp;

class UserRoleEntity {
  final String id;
  final String name;
  final List<UserRoleAssignmentEntity> assignments;

  UserRoleEntity({
    required this.id,
    required this.name,
    this.assignments = const [],
  });

  factory UserRoleEntity.fromMap(Map<String, dynamic> map) {
    return UserRoleEntity(
      id: map['user_role_id'] as String,
      name: map['user_role_name'] as String,
      // Maps nested assignments if they exist in the JSON
      assignments:
          (map['assignments'] as List<dynamic>?)
              ?.map(
                (e) =>
                    UserRoleAssignmentEntity.fromMap(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  // Helper method to update an assignment within this role
  UserRoleEntity copyWith({
    String? name,
    List<UserRoleAssignmentEntity>? assignments,
  }) {
    return UserRoleEntity(
      id: id,
      name: name ?? this.name,
      assignments: assignments ?? this.assignments,
    );
  }

  /// 1. Adds a new assignment to the list
  UserRoleEntity addAssignment(UserRoleAssignmentEntity newAssignment) {
    if (assignments.contains(newAssignment)) {
      return this;
    }

    return copyWith(assignments: [...assignments, newAssignment]);
  }

  /// 2. Replaces an existing assignment by its ID
  UserRoleEntity updateAssignment(UserRoleAssignmentEntity updatedAssignment) {
    final updatedList = assignments.map((attr) {
      return attr.id == updatedAssignment.id ? updatedAssignment : attr;
    }).toList();

    return copyWith(assignments: updatedList);
  }

  /// 3. Removes an assignment by its ID
  UserRoleEntity removeAssignment(String assignmentId) {
    return copyWith(
      assignments: assignments
          .where((attr) => attr.id != assignmentId)
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

  /// Returns a line-separated string of all assignments
  String getPermissionAssignments() {
    if (assignments.isEmpty) return "NO PERMISSION ASSIGNMENTS";

    return assignments.map((assignment) => assignment.toString()).join('\n');
  }

  @override
  String toString() => name;

  String bigView() {
    return "$id\n$name\n${getPermissionAssignments()}";
  }

  // Add this method inside your UserRoleEntity class
  Map<String, dynamic> toMap() {
    return {
      'user_role_id': id,
      'user_role_name': name,
      'assignments': assignments.map((x) => x.toMap()).toList(),
    };
  }
}
