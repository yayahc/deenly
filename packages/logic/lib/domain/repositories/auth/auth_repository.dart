import '../../entities/entities.dart';

abstract class IAuthRepository {
  Future<UserEntity> signInWithGoogle();
  Future<bool> logout(String token);
}
