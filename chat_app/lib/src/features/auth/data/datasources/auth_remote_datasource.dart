import 'package:chat_app/src/core/local/secure_storage_service.dart';
import 'package:chat_app/src/core/network/api_client.dart';
import 'package:chat_app/src/core/network/api_success.dart';

class AuthApi {
  final ApiClient client;

  AuthApi(this.client);

  Future<ApiSuccess<dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final res = await client.post(
      '/api/login',
      withAuth: false,
      body: {'email': email, 'password': password},
    );

    final data = res.data;
    final token = data?['token']?.toString();

    if (token != null) {
      client.setToken(token);
      await SecureStorageService().setItem('token', token);
    }

    return res;
  }
}
