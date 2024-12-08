part of 'login_page_bloc.dart';

@immutable
sealed class LoginPageEvent {}

class LoginEmailChanged extends LoginPageEvent {
  final String email;
  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginPageEvent {
  final String password;
  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginPageEvent {
  final SignInRequestModel signInRequestModel;

  LoginSubmitted({required this.signInRequestModel});
}

class TogglePasswordVisibility extends LoginPageEvent {
  final bool isVisible;
  TogglePasswordVisibility({required this.isVisible});
}
