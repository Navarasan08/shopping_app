part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthenticated extends AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login(this.email, this.password);
}

class SignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String imageUrl;
  final String dob;

  SignUp({this.email, this.password, this.name, this.imageUrl, this.dob});
}

class LogOut extends AuthEvent {}

