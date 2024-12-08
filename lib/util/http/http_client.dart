import 'package:task_tracker/features/authentication/signin_api.dart/signin_mock_api.dart';

class CHttpClient {
  CHttpClient._();

  static Future<Map<String, dynamic>> post(dynamic model) async {
    final response = await SigninMockApi().login(model);
    return response;
  }
}
