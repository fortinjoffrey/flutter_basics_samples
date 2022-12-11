// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventStore on _EventStore, Store {
  Computed<bool>? _$isFetchingEventComputed;

  @override
  bool get isFetchingEvent =>
      (_$isFetchingEventComputed ??= Computed<bool>(() => super.isFetchingEvent,
              name: '_EventStore.isFetchingEvent'))
          .value;
  Computed<bool>? _$isFetchingCompleteComputed;

  @override
  bool get isFetchingComplete => (_$isFetchingCompleteComputed ??=
          Computed<bool>(() => super.isFetchingComplete,
              name: '_EventStore.isFetchingComplete'))
      .value;
  Computed<EventDate?>? _$previewedDateComputed;

  @override
  EventDate? get previewedDate => (_$previewedDateComputed ??=
          Computed<EventDate?>(() => super.previewedDate,
              name: '_EventStore.previewedDate'))
      .value;
  Computed<EventDateMode>? _$eventDateModeComputed;

  @override
  EventDateMode get eventDateMode => (_$eventDateModeComputed ??=
          Computed<EventDateMode>(() => super.eventDateMode,
              name: '_EventStore.eventDateMode'))
      .value;
  Computed<Event?>? _$eventComputed;

  @override
  Event? get event => (_$eventComputed ??=
          Computed<Event?>(() => super.event, name: '_EventStore.event'))
      .value;

  late final _$_eventAtom = Atom(name: '_EventStore._event', context: context);

  @override
  ObservableFuture<Event?> get _event {
    _$_eventAtom.reportRead();
    return super._event;
  }

  @override
  set _event(ObservableFuture<Event?> value) {
    _$_eventAtom.reportWrite(value, super._event, () {
      super._event = value;
    });
  }

  late final _$_previewedDateAtom =
      Atom(name: '_EventStore._previewedDate', context: context);

  @override
  EventDate? get _previewedDate {
    _$_previewedDateAtom.reportRead();
    return super._previewedDate;
  }

  @override
  set _previewedDate(EventDate? value) {
    _$_previewedDateAtom.reportWrite(value, super._previewedDate, () {
      super._previewedDate = value;
    });
  }

  late final _$_updatedEventDatesAtom =
      Atom(name: '_EventStore._updatedEventDates', context: context);

  @override
  List<EventDate>? get _updatedEventDates {
    _$_updatedEventDatesAtom.reportRead();
    return super._updatedEventDates;
  }

  @override
  set _updatedEventDates(List<EventDate>? value) {
    _$_updatedEventDatesAtom.reportWrite(value, super._updatedEventDates, () {
      super._updatedEventDates = value;
    });
  }

  late final _$_eventDateModeAtom =
      Atom(name: '_EventStore._eventDateMode', context: context);

  @override
  EventDateMode get _eventDateMode {
    _$_eventDateModeAtom.reportRead();
    return super._eventDateMode;
  }

  @override
  set _eventDateMode(EventDateMode value) {
    _$_eventDateModeAtom.reportWrite(value, super._eventDateMode, () {
      super._eventDateMode = value;
    });
  }

  late final _$fetchEventAsyncAction =
      AsyncAction('_EventStore.fetchEvent', context: context);

  @override
  Future<void> fetchEvent() {
    return _$fetchEventAsyncAction.run(() => super.fetchEvent());
  }

  late final _$_getEventAsyncAction =
      AsyncAction('_EventStore._getEvent', context: context);

  @override
  Future<Event> _getEvent() {
    return _$_getEventAsyncAction.run(() => super._getEvent());
  }

  late final _$_EventStoreActionController =
      ActionController(name: '_EventStore', context: context);

  @override
  void setPreviewedDate(EventDate date) {
    final _$actionInfo = _$_EventStoreActionController.startAction(
        name: '_EventStore.setPreviewedDate');
    try {
      return super.setPreviewedDate(date);
    } finally {
      _$_EventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onEventDatesChanged(List<EventDate> eventDates) {
    final _$actionInfo = _$_EventStoreActionController.startAction(
        name: '_EventStore.onEventDatesChanged');
    try {
      return super.onEventDatesChanged(eventDates);
    } finally {
      _$_EventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectionMode(EventDateMode newMode) {
    final _$actionInfo = _$_EventStoreActionController.startAction(
        name: '_EventStore.updateSelectionMode');
    try {
      return super.updateSelectionMode(newMode);
    } finally {
      _$_EventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFetchingEvent: ${isFetchingEvent},
isFetchingComplete: ${isFetchingComplete},
previewedDate: ${previewedDate},
eventDateMode: ${eventDateMode},
event: ${event}
    ''';
  }
}
