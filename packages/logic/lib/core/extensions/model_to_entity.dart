import 'package:logic/data/models/user/user_model.dart';

import '../../domain/entities/entities.dart';

extension UserModelToEntity on UserModel {
  UserEntity get toEntity =>
      UserEntity(type: type, token: token, createdAt: createdAt);
}
