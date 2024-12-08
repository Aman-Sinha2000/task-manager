part of 'login_page_bloc.dart';

@immutable
sealed class LoginPageState {}

class LoginInitial extends LoginPageState {}

class LoginLoading extends LoginPageState {}

class LoginSuccess extends LoginPageState {}

class LoginFailure extends LoginPageState {
  final String message;

  LoginFailure(this.message);
}

class LoginValidationState extends LoginPageState {
  final String? emailError;
  final String? passwordError;

  LoginValidationState({this.emailError, this.passwordError});
}

class PasswordState extends LoginPageState {
  final bool isPasswordVisible;

  PasswordState({required this.isPasswordVisible});
}
