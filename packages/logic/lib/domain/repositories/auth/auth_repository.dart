import 'package:logic/domain/entities/user/user_entities.dart';

abstract class IAuthRepository {
  Future<UserEntity> signInWithGoogle();
  Future<bool> logout(String token);
}
