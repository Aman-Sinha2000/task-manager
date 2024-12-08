import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker/features/add_task/add_task_page_bloc/add_task_bloc.dart';
import 'package:task_tracker/features/authentication/signin_bloc/login_page_bloc.dart';
import 'package:task_tracker/features/home/fetch_task_page_bloc/fetch_task_bloc.dart';
import 'package:task_tracker/features/navigation/navigation_page_bloc/navigation_bloc.dart';
import 'package:task_tracker/features/profile/profile_page_bloc/profile_bloc.dart';
import 'package:task_tracker/features/splash/views/splash_page.dart';
import 'package:task_tracker/features/task_details/bloc/update_task_bloc.dart';
import 'package:task_tracker/util/local_storage/storage_utility.dart';
import 'package:task_tracker/util/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final CLocalStorage cLocalStorageInstance = CLocalStorage.appDataBase;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginPageBloc>(
          create: (context) => LoginPageBloc(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(cLocalStorage: cLocalStorageInstance),
        ),
        BlocProvider<FetchTaskBloc>(
          create: (context) =>
              FetchTaskBloc(cLocalStorage: cLocalStorageInstance),
        ),
        BlocProvider<UpdateTaskBloc>(
          create: (context) =>
              UpdateTaskBloc(cLocalStorage: cLocalStorageInstance),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: CAppTheme.lightTheme,
        darkTheme: CAppTheme.darkTheme,
        home: const SplashPage(),
      ),
    );
  }
}
