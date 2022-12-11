import 'package:collection/collection.dart';
import 'package:basics_samples/data/api_source.dart';
import 'package:basics_samples/event_dates/event_dates_widget.dart';
import 'package:basics_samples/models.dart';
import 'package:mobx/mobx.dart';

part 'event_store.g.dart';

// ignore: library_private_types_in_public_api
class EventStore = _EventStore with _$EventStore;

abstract class _EventStore with Store {
  final ApiSource _apiSource;
  final String _eventId;

  _EventStore(this._apiSource, this._eventId);

  @observable
  ObservableFuture<Event?> _event = ObservableFuture.value(null);

  @computed
  bool get isFetchingEvent => _event.status == FutureStatus.pending;

  @computed
  bool get isFetchingComplete => _event.status == FutureStatus.fulfilled;

  @observable
  EventDate? _previewedDate;

  @observable
  List<EventDate>? _updatedEventDates;

  @computed
  EventDate? get previewedDate {
    return _updatedEventDates?.firstWhereOrNull(
      (e) => e.state == EventDateState.previewed || e.state == EventDateState.selectedPreviewed,
    );
  }

  @observable
  EventDateMode _eventDateMode = EventDateMode.preview;

  @computed
  EventDateMode get eventDateMode => _eventDateMode;

  @computed
  Event? get event => _event.value;

  @action
  Future<void> fetchEvent() async {
    _event = ObservableFuture(_getEvent());
  }

  @action
  Future<Event> _getEvent() async {
    final event = await _apiSource.getEvent(_eventId);

    // On event fetched, we need to know if there's a selected date.
    // If so, we have to make the selected date previewed
    // If not, the first date will be set to previewed state

    final selectedEventIndex = event.proposedDates.indexWhere((e) => e.state == EventDateState.selected);

    if (selectedEventIndex != -1) {
      event.proposedDates[selectedEventIndex] = EventDate(
        date: event.proposedDates[selectedEventIndex].date,
        state: EventDateState.selectedPreviewed,
      );
      _updatedEventDates = event.proposedDates;
      _eventDateMode = EventDateMode.previewPostSelection;
      return event;
    }

    event.proposedDates.first = EventDate(date: event.proposedDates.first.date, state: EventDateState.previewed);
    _updatedEventDates = event.proposedDates;
    return event;
  }

  @action
  void setPreviewedDate(EventDate date) {
    _previewedDate = date;
  }

  @action
  void onEventDatesChanged(List<EventDate> eventDates) {
    _updatedEventDates = eventDates;
  }

  @action
  void updateSelectionMode(EventDateMode newMode) {
    _eventDateMode = newMode;
  }
}
