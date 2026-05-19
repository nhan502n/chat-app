import 'package:chat_app/src/core/network/api_exception.dart';
import 'package:chat_app/src/core/network/api_success.dart';
import 'package:chat_app/src/features/auth/data/models/user_model.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc(this._repo) : super(AuthInitial()) {
    on<AuthSignInEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final res = await _repo.signIn(
          email: event.email,
          password: event.password,
        );

        final user = User.fromJson(res.data);

        emit(
          AuthSuccess(
            ApiSuccess(
              statusCode: res.statusCode,
              message: res.message,
              data: user,
              rawBody: res.rawBody,
            ),
          ),
        );
      } on ApiException catch (e) {
        emit(AuthError(e));
      }
    });
  }
}
