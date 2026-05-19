import 'package:chat_app/src/core/network/api_exception.dart';
import 'package:chat_app/src/core/network/api_success.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final ApiSuccess data;

  AuthSuccess(this.data);
}

class AuthError extends AuthState {
  final ApiException error;

  AuthError(this.error);
}
