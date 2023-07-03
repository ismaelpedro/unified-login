import 'package:unified_login/models/user.dart';

extension UserPermissionsDto on UserPermissions {
  static UserPermissions fromJson(Map<String, dynamic> json) {
    return UserPermissions(
      permissionId: json['permissionId'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['permissionId'] = permissionId;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}
