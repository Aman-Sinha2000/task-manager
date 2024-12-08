import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/features/add_task/views/add_task_page.dart';
import 'package:task_tracker/features/home/views/home_page.dart';
import 'package:task_tracker/features/navigation/navigation_page_bloc/navigation_event.dart';
import 'package:task_tracker/features/profile/views/profie_page.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          NavigationState(
              selectedIndex: 0, appBarTitle: 'Home', body: const HomePage()),
        ) {
    on<NavigationItemTapped>((event, emit) {
      switch (event.index) {
        case 0:
          emit(
            NavigationState(
              selectedIndex: 0,
              appBarTitle: 'Home',
              body: HomePage(),
            ),
          );
          break;
        case 1:
          emit(
            NavigationState(
              selectedIndex: 1,
              appBarTitle: 'Search',
              body: const AddTaskPage(),
            ),
          );
          break;
        case 2:
          emit(
            NavigationState(
              selectedIndex: 2,
              appBarTitle: 'Profile',
              body: const ProfiePage(),
            ),
          );
          break;
      }
    });
  }
}
