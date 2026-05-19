import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/src/features/landing/domain/repositories/chat_realtime_repository.dart';
import 'package:chat_app/src/features/landing/presentation/bloc/chat_bloc.dart';

import '../injection/injection.dart';

class BlocModule extends DIModule {
  @override
  Future<void> provides() async {
    final authRepo = getIt<AuthRepository>();
    final chatRepo = getIt<ChatRealtimeRepository>();
    getIt.registerFactory(() => AuthBloc(authRepo));
    getIt.registerFactory(() => ChatBloc(chatRepo));
  }
}
