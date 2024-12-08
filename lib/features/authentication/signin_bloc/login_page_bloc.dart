import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_tracker/data/request_models/signin_request_model.dart';
import 'package:task_tracker/data/response_models/signin_response_model.dart';
import 'package:task_tracker/data/response_models/signin_response_model_error.dart';
import 'package:task_tracker/util/http/http_client.dart';
import 'package:task_tracker/util/local_storage/shared_prefrences.dart';
import 'package:task_tracker/util/logging/logger.dart';
import 'package:task_tracker/util/validators/validation.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginInitial()) {
    on<LoginEmailChanged>((event, emit) {
      String? emailError = CValidation.validateEmail(event.email);
      if (emailError != null) {
        emit(LoginValidationState(emailError: emailError));
      } else {
        emit(LoginValidationState(emailError: null));
      }
    });

    on<LoginPasswordChanged>((event, emit) {
      String? passwordError = CValidation.validatePassword(event.password);
      if (passwordError != null) {
        emit(LoginValidationState(passwordError: passwordError));
      } else {
        emit(LoginValidationState(passwordError: null));
      }
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(PasswordState(isPasswordVisible: !event.isVisible));
    });

    on<LoginSubmitted>((event, emit) async {
      CLoggerHelper.info(event.signInRequestModel.email);
      CLoggerHelper.info(event.signInRequestModel.password);

      //* Validate Email
      String? emailError =
          CValidation.validateEmail(event.signInRequestModel.email);
      String? passwordError =
          CValidation.validatePassword(event.signInRequestModel.password);
      if (emailError == null && passwordError == null) {
        emit(LoginValidationState(
            emailError: emailError, passwordError: emailError));
      } else {
        emit(LoginValidationState(
            emailError: emailError, passwordError: passwordError));
        CLoggerHelper.error(emailError ?? '');
        CLoggerHelper.error(passwordError ?? '');
        return;
      }

      //* Validate Password

      // if (passwordError != null) {
      //   emit(LoginValidationState(passwordError: passwordError));
      //   CLoggerHelper.debug(passwordError);
      //   return;
      // } else {
      //   emit(LoginValidationState(passwordError: null));
      // }

      emit(LoginLoading());

      //* API Call
      Map<String, dynamic> response =
          await CHttpClient.post(event.signInRequestModel);
      if (response['status'] == 'success') {
        //* Store user data in SharedPreferences
        SignInResponseModel model = SignInResponseModel.fromJson(response);
        CLoggerHelper.info(model);
        final CSharedPreferencesServices prefs =
            await CSharedPreferencesServices.getInstance();
        prefs.userId = model.user.id;
        prefs.userEmail = model.user.email;
        prefs.userName = model.user.name;
        prefs.isLoggedIn = true;
        emit(LoginSuccess());
      } else {
        SigninResponseModelError error =
            SigninResponseModelError.fromJson(response);
        CLoggerHelper.info(error.message);
        emit(LoginFailure(error.message));
      }
    });
  }
}
