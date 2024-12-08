import 'package:task_tracker/data/request_models/signin_request_model.dart';

class SigninMockApi {
  Future<Map<String, dynamic>> login(SignInRequestModel model) async {
    //For some delay
    await Future.delayed(const Duration(seconds: 2));

    if (model.email == "Tarun@example.com" && model.password == "Tarun@123") {
      return {
        "status": "success",
        "user": {
          "id": "1",
          "name": "Tarun Lohni",
          "email": model.email,
        }
      };
    } else {
      return {
        "status": "error",
        "message": "Invalid email or password",
      };
    }
  }
}
