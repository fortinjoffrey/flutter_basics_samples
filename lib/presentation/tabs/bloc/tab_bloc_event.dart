enum Tabs {
  calendar,
  admin,
}

sealed class TabEvent {}

class TabChangedEvent extends TabEvent {
  final Tabs tab;

  TabChangedEvent({required this.tab});
}
