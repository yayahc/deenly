import 'package:dartz/dartz.dart';
import 'package:logic/domain/repositories/auth/auth_repository.dart';
import '../../../core/error/error.dart';
import '../../entities/entities.dart';

class AuthUsecases {
  final IAuthRepository _authRepository;

  AuthUsecases(this._authRepository);

  Future<Either<SystemError, UserEntity>> signInWithGoogle() async {
    try {
      return right(await _authRepository.signInWithGoogle());
    } catch (e, s) {
      return left(
        GenericError(
          devErrorMessage: '$e',
          userFriendlyDevErrorMessage: 'logout sign in with google',
          stackTrace: '$s',
        ),
      );
    }
  }

  Future<Either<SystemError, bool>> logout(String userToken) async {
    try {
      return right(await _authRepository.logout(userToken));
    } catch (e, s) {
      return left(
        GenericError(
          devErrorMessage: '$e',
          userFriendlyDevErrorMessage: 'logout failed',
          stackTrace: '$s',
        ),
      );
    }
  }
}
