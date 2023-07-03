import 'package:unified_login/models/user.dart';
import 'package:unified_login/models/user_permissions_dto.dart';

extension PermissionsDto on Permissions {
  static Permissions fromJson(Map<String, dynamic> json) {
    return Permissions(
      id: json['id'],
      permission: json['permission'],
      description: json['description'],
      ldapPermissionName: json['ldapPermissionName'],
      isModule: json['isModule'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      userPermissions: json['UserPermissions'] != null ? UserPermissionsDto.fromJson(json['UserPermissions']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['permission'] = permission;
    data['ldapPermissionName'] = ldapPermissionName;
    data['isModule'] = isModule;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    if (userPermissions != null) {
      data['UserPermissions'] = userPermissions!.toJson();
    }
    return data;
  }
}
