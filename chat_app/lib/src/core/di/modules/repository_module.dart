import 'package:chat_app/src/core/di/injection/injection.dart';
import 'package:chat_app/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:chat_app/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/landing/data/repositories/chat_realtime_repository_impl.dart';
import 'package:chat_app/src/features/landing/domain/repositories/chat_realtime_repository.dart';

class RepositoryModule extends DIModule {
  @override
  Future<void> provides() async {
    final authApi = getIt<AuthApi>();

    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authApi),
    );
    getIt.registerLazySingleton<ChatRealtimeRepository>(
      () => ChatRealtimeRepositoryImpl(getIt()),
    );
  }
}
