import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final String userName = await CHelperFunctions.getUserName();
        final String userId = await CHelperFunctions.geUserId();
        final String userEmail = await CHelperFunctions.geUserEmail();

        if (userName != '' && userId != '' && userEmail != '') {
          emit(ProfileLoaded(
            userName: userName,
            userId: userId,
            userEmail: userEmail,
          ));
        } else {
          emit(ProfileError("Failed to load user data."));
        }
      } catch (e) {
        emit(ProfileError("Error fetching user data: ${e.toString()}"));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        CHelperFunctions.setUserName(event.userName);
        CHelperFunctions.setUserId(event.userId);
        CHelperFunctions.setUserEmail(event.userEmail);
        CHelperFunctions.setIsLoggedIn(event.isLoggedIn);

        emit(
          ProfileUpdated(),
        );
      } catch (e) {
        emit(ProfileError("Error updating user data: ${e.toString()}"));
      }
    });
  }
}
