import 'package:basics_samples/event_dates/event_dates_widget.dart';
import 'package:basics_samples/models.dart';
import 'package:mobx/mobx.dart';
import 'package:collection/collection.dart';

part 'event_dates_widget_store.g.dart';

// ignore: library_private_types_in_public_api
class EventDatesWidgetStore = _EventDatesWidgetStore with _$EventDatesWidgetStore;

abstract class _EventDatesWidgetStore with Store {
  _EventDatesWidgetStore({
    required List<EventDate> eventDates,
    required EventDateMode mode,
  })  : _eventDates = ObservableList.of(eventDates),
        _mode = mode;

  EventDateMode _mode;

  set mode(EventDateMode newMode) => _mode = newMode;

  @observable
  ObservableList<EventDate> _eventDates;

  @computed
  ObservableList<EventDate> get eventDates => ObservableList<EventDate>.of(_eventDates);

  @computed
  EventDate? get previewedDate => _eventDates.firstWhereOrNull((e) => e.state == EventDateState.previewed);

  @action
  void onEventDateTapped(int index) {
    final eventDate = _eventDates.elementAt(index);

    _performStateChangesForOtherEventDates(eventDate.state);

    final newState = _getTappedEventDateNewState(eventDate.state);
    final updatedEventDate = EventDate(date: eventDate.date, state: newState);

    _eventDates[index] = updatedEventDate;
  }

  @action
  void _performStateChangesForOtherEventDates(EventDateState previousState) {
    switch (_mode) {
      case EventDateMode.preview:
        if (previousState == EventDateState.unselected) {
          _eventDates = ObservableList<EventDate>.of(
            _eventDates.map((e) => EventDate(date: e.date, state: EventDateState.unselected)).toList(),
          );
        }
        return;
      case EventDateMode.selection:
        _eventDates = ObservableList<EventDate>.of(
          _eventDates.map(
            (e) {
              EventDateState newState = e.state;

              if (e.state == EventDateState.selectedPreviewed) {
                newState = EventDateState.selected;
              } else if (e.state == EventDateState.previewed) {
                newState = EventDateState.unselected;
              }

              return EventDate(date: e.date, state: newState);
            },
          ).toList(),
        );
        return;
      case EventDateMode.previewPostSelection:
        if (previousState == EventDateState.unselected || previousState == EventDateState.selected) {
          _eventDates = ObservableList<EventDate>.of(
            _eventDates.map(
              (e) {
                EventDateState newState = e.state;

                if (e.state == EventDateState.selectedPreviewed) {
                  newState = EventDateState.selected;
                } else if (e.state == EventDateState.previewed) {
                  newState = EventDateState.unselected;
                }

                return EventDate(date: e.date, state: newState);
              },
            ).toList(),
          );
          return;
        }
    }
  }

  EventDateState _getTappedEventDateNewState(EventDateState currentState) {
    switch (_mode) {
      case EventDateMode.preview:
        return _getStateForPreviewMode(currentState);
      case EventDateMode.selection:
        return _getStateForSelectionMode(currentState);
      case EventDateMode.previewPostSelection:
        return _getStateForPreviewPostSelectionMode(currentState);
    }
  }

  EventDateState _getStateForPreviewMode(EventDateState currentState) {
    switch (currentState) {
      case EventDateState.unselected:
        return EventDateState.previewed;
      case EventDateState.previewed:
      case EventDateState.selected:
      case EventDateState.selectedPreviewed:
        return currentState;
    }
  }

  EventDateState _getStateForSelectionMode(EventDateState currentState) {
    switch (currentState) {
      case EventDateState.unselected:
        return EventDateState.selectedPreviewed;
      case EventDateState.previewed:
        return EventDateState.selectedPreviewed;
      case EventDateState.selected:
        return EventDateState.selectedPreviewed;
      case EventDateState.selectedPreviewed:
        return EventDateState.previewed;
    }
  }

  EventDateState _getStateForPreviewPostSelectionMode(EventDateState currentState) {
    switch (currentState) {
      case EventDateState.unselected:
        return EventDateState.previewed;
      case EventDateState.previewed:
      case EventDateState.selectedPreviewed:
        return currentState;
      case EventDateState.selected:
        return EventDateState.selectedPreviewed;
    }
  }
}
