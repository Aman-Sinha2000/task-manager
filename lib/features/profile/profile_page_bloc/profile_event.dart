part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String userName;
  final String userId;
  final String userEmail;
  final bool isLoggedIn;

  UpdateProfileEvent(
      {required this.userName,
      required this.userId,
      required this.userEmail,
      required this.isLoggedIn});
}
