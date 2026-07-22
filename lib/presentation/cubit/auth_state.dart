abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}


class SignUpSuccess extends AuthState {
  final String email;
  SignUpSuccess({required this.email});
}


class VerifyEmailSuccess extends AuthState {}


class LoginSuccess extends AuthState {
  final String token;
  LoginSuccess({required this.token});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}