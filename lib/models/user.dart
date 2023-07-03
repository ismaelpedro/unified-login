enum CollaboratorStatus {
  away('Ausente'),
  avaiable('Disponível'),
  busy('Ocupado');

  final String value;
  const CollaboratorStatus(this.value);
}

class Collaborator {
  final int id;
  final String name;
  final String? phone;
  final CollaboratorStatus? status;
  final String department;
  final String? firebaseToken;
  final String? availableTimestamp;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  Collaborator({
    required this.id,
    required this.name,
    this.phone,
    this.status,
    required this.department,
    this.firebaseToken,
    this.availableTimestamp,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  String toString() {
    return 'Collaborator(id: $id, name: $name, phone: $phone, status: $status, department: $department, firebaseToken: $firebaseToken, availableTimestamp: $availableTimestamp, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  Collaborator copyWith({
    int? id,
    String? name,
    String? phone,
    CollaboratorStatus? status,
    String? department,
    String? firebaseToken,
    String? availableTimestamp,
    int? userId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Collaborator(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      department: department ?? this.department,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      availableTimestamp: availableTimestamp ?? this.availableTimestamp,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}

class UserPermissions {
  int? permissionId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserPermissions({
    this.permissionId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
}

class Permissions {
  int? id;
  String? description;
  String? permission;
  String? ldapPermissionName;
  bool? isModule;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  UserPermissions? userPermissions;

  Permissions({
    this.id,
    this.description,
    this.permission,
    this.ldapPermissionName,
    this.isModule,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userPermissions,
  });
}

class User {
  int id;
  int? userId;
  String? username;
  String? collaboratorName;
  String? name;
  String? password;
  String? status;
  String? phone;
  String? token;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? firebaseToken;
  int? collaboratorId;
  List<Permissions>? permissions = [];
  Collaborator? collaborator;

  User({
    required this.id,
    this.userId,
    this.username,
    this.collaboratorName,
    required this.name,
    this.password,
    this.token,
    this.status,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.permissions,
    this.firebaseToken,
    this.collaboratorId,
    this.collaborator,
  });

  bool get isCAA => collaborator?.department == 'CAA';
  String? get department => collaborator?.department;
  String get departmentString => collaborator?.department == 'CAA'
      ? 'Acolhimento'
      : collaborator?.department == 'CAT'
          ? 'Transporte'
          : 'Liberação de Leitos';

  @override
  String toString() {
    return 'User(id: $id, username: $username, name: $name, password: $password, token: $token, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, firebaseToken: $firebaseToken, permissions: $permissions, collaborator: $collaborator)';
  }

  User copyWith({
    int? id,
    int? userId,
    String? username,
    String? name,
    String? password,
    String? status,
    String? phone,
    String? token,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? firebaseToken,
    List<Permissions>? permissions,
    Collaborator? collaborator,
  }) {
    return User(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      name: name ?? this.name,
      password: password ?? this.password,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      permissions: permissions ?? this.permissions,
      collaborator: collaborator ?? this.collaborator,
    );
  }
}
