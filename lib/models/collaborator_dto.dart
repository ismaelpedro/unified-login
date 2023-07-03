
import 'package:unified_login/extensions/string_extensions.dart';
import 'package:unified_login/models/user.dart';

extension CollaboratorDto on Collaborator {
  static Collaborator fromJson(Map<String, dynamic> json) {
    return Collaborator(
      id: json['id'],
      name: json['name'],
      availableTimestamp: json['availableTimestamp'],
      createdAt: json['createdAt'],
      deletedAt: json['deletedAt'],
      department: json['department'],
      firebaseToken: json['firebaseToken'],
      phone: json['phone'],
      status: json['status'].toString().toCollaboratorStatusEnum(),
      updatedAt: json['updatedAt'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'availableTimestamp': availableTimestamp,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'department': department,
      'updatedAt': updatedAt,
      'userId': userId,
      // 'status': status,
      'status': status?.value,
      'firebaseToken': firebaseToken,
      'phone': phone,
    };
  }
}
