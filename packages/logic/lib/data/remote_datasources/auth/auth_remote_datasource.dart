import 'package:logic/data/models/user/user_model.dart';

abstract class IAuthRemoteDatasource {
  Future<UserModel> signInWithGoogle();
  Future<bool> logout(String token);
}

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  @override
  Future<bool> logout(String token) async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
