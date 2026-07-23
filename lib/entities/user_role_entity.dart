part of catapiljaapp;

class UserRoleEntity {
  final String id;
  final String name;
  final List<UserRoleDefinitionsEntity> definitions;

  UserRoleEntity({
    required this.id,
    required this.name,
    this.definitions = const [],
  });

  factory UserRoleEntity.fromMap(Map<String, dynamic> map) {
    return UserRoleEntity(
      id: map['user_role_id'] as String,
      name: map['user_role_name'] as String,
      // Maps nested definitions if they exist in the JSON
      definitions:
          (map['definitions'] as List<dynamic>?)
              ?.map(
                (e) => UserRoleDefinitionsEntity.fromMap(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  // Helper method to update an definition within this role
  UserRoleEntity copyWith({
    String? name,
    List<UserRoleDefinitionsEntity>? definitions,
  }) {
    return UserRoleEntity(
      id: id,
      name: name ?? this.name,
      definitions: definitions ?? this.definitions,
    );
  }

  /// 1. Adds a new definition to the list
  UserRoleEntity addDefinition(UserRoleDefinitionsEntity newDefinition) {
    if (definitions.contains(newDefinition)) {
      return this;
    }

    return copyWith(definitions: [...definitions, newDefinition]);
  }

  /// 2. Replaces an existing definition by its ID
  UserRoleEntity updateDefinition(UserRoleDefinitionsEntity updatedDefinition) {
    final updatedList = definitions.map((attr) {
      return attr.id == updatedDefinition.id ? updatedDefinition : attr;
    }).toList();

    return copyWith(definitions: updatedList);
  }

  /// 3. Removes an definition by its ID
  UserRoleEntity removeDefinition(String definitionId) {
    return copyWith(
      definitions: definitions
          .where((attr) => attr.id != definitionId)
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

  /// Returns a line-separated string of all definitions
  String getPermissiondefinitions() {
    if (definitions.isEmpty) return "NO PERMISSION definitions";

    return definitions.map((definition) => definition.toString()).join('\n');
  }

  @override
  String toString() => name;

  String bigView() {
    return "$id\n$name\n${getPermissiondefinitions()}";
  }

  // Add this method inside your UserRoleEntity class
  Map<String, dynamic> toMap() {
    return {
      'user_role_id': id,
      'user_role_name': name,
      'definitions': definitions.map((x) => x.toMap()).toList(),
    };
  }
}
