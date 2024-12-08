import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_tracker/features/authentication/views/signin.dart';
import 'package:task_tracker/features/navigation/views/naviagtion_page.dart';
import 'package:task_tracker/util/constants/sizes.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';
import 'package:task_tracker/util/local_storage/shared_prefrences.dart';
import 'package:task_tracker/util/logging/logger.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    moveToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    //CollectionReference reference = firestore.collection('users');
    return const Scaffold(
        body: Center(
      child: FlutterLogo(
        size: CSizes.imageMd,
      ),
    ));
  }

  void moveToNextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    final instance = await CSharedPreferencesServices.getInstance();
    CLoggerHelper.error('Id: ${instance.userId}');
    CLoggerHelper.error('Is Logged In: ${instance.isLoggedIn}');
    instance.isLoggedIn
        ? CHelperFunctions.pushReplacement(context, const NaviagtionPage())
        : CHelperFunctions.pushReplacement(context, const Signin());
  }
}
