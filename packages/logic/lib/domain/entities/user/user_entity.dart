import '../../../data/models/user/user_model.dart';

class UserEntity {
  String? token;
  final UserType type;
  DateTime? createdAt;

  UserEntity({required this.type, this.token, this.createdAt});
}
