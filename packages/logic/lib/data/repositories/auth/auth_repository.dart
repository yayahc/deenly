import 'package:logic/core/extensions/extensions.dart';
import 'package:logic/domain/entities/user/user_entity.dart';
import 'package:logic/domain/repositories/auth/auth_repository.dart';
import '../../remote_datasources/auth/auth_remote_datasource.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDatasource _iAuthRemoteDatasource;

  AuthRepository(this._iAuthRemoteDatasource);

  @override
  Future<bool> logout(String token) async {
    return _iAuthRemoteDatasource.logout(token);
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    return (await _iAuthRemoteDatasource.signInWithGoogle()).toEntity;
  }
}
