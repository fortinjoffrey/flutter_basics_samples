// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dates_widget_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventDatesWidgetStore on _EventDatesWidgetStore, Store {
  Computed<ObservableList<EventDate>>? _$eventDatesComputed;

  @override
  ObservableList<EventDate> get eventDates => (_$eventDatesComputed ??=
          Computed<ObservableList<EventDate>>(() => super.eventDates,
              name: '_EventDatesWidgetStore.eventDates'))
      .value;
  Computed<EventDate?>? _$previewedDateComputed;

  @override
  EventDate? get previewedDate => (_$previewedDateComputed ??=
          Computed<EventDate?>(() => super.previewedDate,
              name: '_EventDatesWidgetStore.previewedDate'))
      .value;

  late final _$_eventDatesAtom =
      Atom(name: '_EventDatesWidgetStore._eventDates', context: context);

  @override
  ObservableList<EventDate> get _eventDates {
    _$_eventDatesAtom.reportRead();
    return super._eventDates;
  }

  @override
  set _eventDates(ObservableList<EventDate> value) {
    _$_eventDatesAtom.reportWrite(value, super._eventDates, () {
      super._eventDates = value;
    });
  }

  late final _$_EventDatesWidgetStoreActionController =
      ActionController(name: '_EventDatesWidgetStore', context: context);

  @override
  void onEventDateTapped(int index) {
    final _$actionInfo = _$_EventDatesWidgetStoreActionController.startAction(
        name: '_EventDatesWidgetStore.onEventDateTapped');
    try {
      return super.onEventDateTapped(index);
    } finally {
      _$_EventDatesWidgetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _performStateChangesForOtherEventDates(EventDateState previousState) {
    final _$actionInfo = _$_EventDatesWidgetStoreActionController.startAction(
        name: '_EventDatesWidgetStore._performStateChangesForOtherEventDates');
    try {
      return super._performStateChangesForOtherEventDates(previousState);
    } finally {
      _$_EventDatesWidgetStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
eventDates: ${eventDates},
previewedDate: ${previewedDate}
    ''';
  }
}
