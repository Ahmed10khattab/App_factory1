part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthGoogleLoading extends AuthState {}

class AuthGoogleAuthenticated extends AuthState {
  final User user;

  AuthGoogleAuthenticated({required this.user});
}

class AuthGoogleError extends AuthState {
  final String message;
  AuthGoogleError(this.message);
}

class AuthLoggedOut extends AuthState {}
