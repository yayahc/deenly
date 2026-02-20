import '../data/models/models.dart';
import '../domain/entities/entities.dart';

extension UserModelToUserEntity on UserModel {
  UserEntity get toEntity =>
      UserEntity(type: type, token: token, createdAt: createdAt);
}

extension DhikrModelToDhikrEntity on DhikrModel {
  DhikrEntity get toEntity => DhikrEntity(
    id: id,
    invocation: invocation,
    subscribers: subscribers,
    benefice: benefice,
    remindAt: remindAt,
  );
}
