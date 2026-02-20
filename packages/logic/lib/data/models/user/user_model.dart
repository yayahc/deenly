enum UserType { user, admin }

class UserModel {
  String? token;
  final UserType type;
  DateTime? createdAt;

  UserModel({required this.type, this.token, this.createdAt});
}
