import 'package:flutter/material.dart';
import 'package:task_tracker/util/local_storage/shared_prefrences.dart';

class CHelperFunctions {
  CHelperFunctions._();
  static CSharedPreferencesServices? cSharedPreferencesServices;
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert(
      BuildContext parentContext, String title, String message) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      },
    );
  }

  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void pushAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Future<String> getUserName() async {
    cSharedPreferencesServices = await CSharedPreferencesServices.getInstance();
    return cSharedPreferencesServices!.userName;
  }

  static Future<String> geUserEmail() async {
    cSharedPreferencesServices = await CSharedPreferencesServices.getInstance();
    return cSharedPreferencesServices!.userEmail;
  }

  static Future<String> geUserId() async {
    cSharedPreferencesServices = await CSharedPreferencesServices.getInstance();
    return cSharedPreferencesServices!.userId;
  }

  static void setUserName(String name) async {
    cSharedPreferencesServices = await CSharedPreferencesServices.getInstance();
    cSharedPreferencesServices!.userName = name;
  }

  static void setUserEmail(String email) async {
    cSharedPreferencesServices = await CSharedPreferencesServices.getInstance();
    cSharedPreferencesServices!.userEmail = email;
  }

  static void setUserId(String userId) async {
    cSharedPreferencesServices = await CSharedPreferencesServices.getInstance();
    cSharedPreferencesServices!.userId = userId;
  }

  static Future<void> setIsLoggedIn(bool isLoggedIn) async {
    cSharedPreferencesServices = await CSharedPreferencesServices.getInstance();
    cSharedPreferencesServices!.isLoggedIn = isLoggedIn;
  }
}
