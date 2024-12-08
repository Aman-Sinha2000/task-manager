import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/logging/logger.dart';

class CValidation {
  CValidation._();
  static String? validateEmail(String email) {
    CLoggerHelper.info(email);
    if (email != "") {
      RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
        caseSensitive: false,
      );
      return emailRegex.hasMatch(email) ? null : CTextStrings.errorEmail;
    } else {
      return CTextStrings.noEmail;
    }
  }

  static String? validatePassword(String password) {
    CLoggerHelper.info(password);
    if (password != '') {
      RegExp passRegExp = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

      return passRegExp.hasMatch(password) ? null : CTextStrings.errorPassword;
    } else {
      return CTextStrings.noPassword;
    }
  }
}
