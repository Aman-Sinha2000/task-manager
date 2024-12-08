part of 'navigation_bloc.dart';

class NavigationState {
  final int selectedIndex;
  final String appBarTitle;
  final Widget body;

  NavigationState({
    required this.selectedIndex,
    required this.appBarTitle,
    required this.body,
  });
}
