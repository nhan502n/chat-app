import 'package:chat_app/src/core/network/api_success.dart';
import 'package:chat_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl(this.authApi);

  @override
  Future<ApiSuccess> signIn({
    required String email,
    required String password,
  }) async {
    final res = await authApi.signIn(email: email, password: password);
    return res;
  }
}
