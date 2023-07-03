import 'package:unified_login/models/collaborator_dto.dart';
import 'package:unified_login/models/permissions_dto.dart';
import 'package:unified_login/models/user.dart';

extension UserDto on User {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      collaboratorId: json['Collaborators'].isNotEmpty ? json['Collaborators'].first['id'] : 0,
      collaboratorName: json['Collaborators'].isNotEmpty ? json['Collaborators'].first['name'] : null,
      password: json['password'],
      token: json['token'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      firebaseToken: json['firebaseToken'],
      permissions: json['Permissions'] != null
          ? List<Permissions>.from(
              json['Permissions']?.map((dynamic p) => PermissionsDto.fromJson(p)),
            )
          : [],
      collaborator: CollaboratorDto.fromJson(json['Collaborators']?.first),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'password': password,
      'token': token,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'firebaseToken': firebaseToken,
      'Collaborators': [collaborator?.toJson()],
      'Permissions': permissions?.map((Permissions p) => p.toJson()).toList(),
    };
  }
}
