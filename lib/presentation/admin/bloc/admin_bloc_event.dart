enum AdminTabs {
  dashboard,
  establishment,
  employees,
}

sealed class AdminEvent {}

class AdminStateChangedEvent extends AdminEvent {
  final AdminTabs tab;

  AdminStateChangedEvent({required this.tab});
}
