abstract class AuthEvent {}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignInEvent(this.email, this.password);
}
