part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginInProgress extends AuthState {}

class LoggedIn extends AuthState {
  final User user;

  LoggedIn(this.user);
}

class LoginError extends AuthState {
  final String error;

  LoginError(this.error);
}

class SignUpInProgress extends AuthState {}

class SignUpError extends AuthState {
  final String error;

  SignUpError(this.error);
}

class UnAuthenticated extends AuthState {}

