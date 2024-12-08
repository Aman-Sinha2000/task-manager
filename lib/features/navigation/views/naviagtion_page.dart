import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker/features/navigation/navigation_page_bloc/navigation_bloc.dart';
import 'package:task_tracker/features/navigation/navigation_page_bloc/navigation_event.dart';

class NaviagtionPage extends StatelessWidget {
  const NaviagtionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: state.body,
          bottomNavigationBar: NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (index) {
                context.read<NavigationBloc>().add(NavigationItemTapped(index));
              },
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.add_circle_outline_sharp),
                    label: 'Add Task'),
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Profile'),
              ]),
        );
      },
    );
  }
}
