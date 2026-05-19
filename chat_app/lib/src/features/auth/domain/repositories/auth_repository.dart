import 'package:chat_app/src/core/network/api_success.dart';

abstract class AuthRepository {
  Future<ApiSuccess> signIn({required String email, required String password});
}
