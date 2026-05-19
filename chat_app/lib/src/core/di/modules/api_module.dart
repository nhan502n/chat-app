import 'package:chat_app/src/core/di/injection/injection.dart';
import 'package:chat_app/src/core/network/api_client.dart';
import 'package:chat_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_app/src/features/landing/data/datasources/chat_realtime_remote_datasource.dart';

class ApiModule extends DIModule {
  @override
  Future<void> provides() async {
    final apiClient = ApiClient();
    getIt.registerSingleton<ApiClient>(ApiClient());
    getIt.registerSingleton<AuthApi>(AuthApi(apiClient));
    getIt.registerLazySingleton<ReverbSocketDataSource>(
      () => ReverbSocketDataSource(getIt<ApiClient>()),
    );
  }
}
