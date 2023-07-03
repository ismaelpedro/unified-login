import 'package:unified_login/models/user.dart';

extension StringExtensions on String {
  CollaboratorStatus toCollaboratorStatusEnum() {
    switch (this) {
      case 'Disponível':
        return CollaboratorStatus.avaiable;
      case 'Ausente':
        return CollaboratorStatus.away;
      case 'Ocupado':
        return CollaboratorStatus.busy;
      default:
        return CollaboratorStatus.avaiable;
    }
  }
}
