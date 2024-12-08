abstract class NavigationEvent {
  const NavigationEvent();
}

class NavigationItemTapped extends NavigationEvent {
  final int index;

  const NavigationItemTapped(this.index);
}
