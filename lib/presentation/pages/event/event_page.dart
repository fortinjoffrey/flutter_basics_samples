import 'package:flutter/material.dart';
import 'package:basics_samples/data/api_source.dart';
import 'package:basics_samples/event_dates/event_dates_widget.dart';
import 'package:basics_samples/models.dart';
import 'package:basics_samples/presentation/pages/event/event_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    super.key,
    required this.eventId,
  });

  final String eventId;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late final EventStore _store;

  @override
  void initState() {
    super.initState();
    _store = EventStore(ApiSource(), widget.eventId);
    _store.fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Observer(builder: (context) {
        return _store.isFetchingEvent ? _buildLoader() : _buildEventWidget();
      }),
    );
  }

  Widget _buildLoader() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEventWidget() {
    final Event? event = _store.event;
    if (event == null) return const Text('Error');

    return Column(
      children: [
        _buildEventName(event),
        Observer(builder: (_) {
          final mode = _store.eventDateMode;
          return EventDatesWidget(
            // key: UniqueKey(),
            eventDates: event.proposedDates,
            mode: mode,
            onEventDatesChanged: (updatedEventDates) {
              _store.onEventDatesChanged(updatedEventDates);
            },
          );
        }),
        Observer(
          builder: (context) {
            final previewedDate = _store.previewedDate;
            if (previewedDate == null) {
              return const Expanded(child: Placeholder());
            }
            return Expanded(
              child: ParticipantsForDate(
                partipants: event.participants,
                eventDate: previewedDate,
              ),
            );
          },
        ),
        Observer(
          builder: (context) {
            return Text(_store.eventDateMode.toString());
          },
        ),
        TextButton(
          onPressed: () {
            _store.updateSelectionMode(EventDateMode.preview);
          },
          child: const Text('preview'),
        ),
        TextButton(
          onPressed: () {
            _store.updateSelectionMode(EventDateMode.selection);
          },
          child: const Text('selection'),
        ),
        TextButton(
          onPressed: () {
            _store.updateSelectionMode(EventDateMode.previewPostSelection);
          },
          child: const Text('previewPostSelection'),
        ),
      ],
    );
  }

  Container _buildEventName(Event event) {
    return Container(
      color: Colors.grey,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: Text(event.name)),
      ),
    );
  }
}

class ParticipantsForDate extends StatelessWidget {
  const ParticipantsForDate({
    super.key,
    required this.partipants,
    required this.eventDate,
  });

  final Set<Participant> partipants;
  final EventDate eventDate;

  @override
  Widget build(BuildContext context) {
    final availableParticipants = partipants.where((p) => p.availableDates.contains(eventDate.date)).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(availableParticipants[index].info.name),
        );
      },
      itemCount: availableParticipants.length,
    );
  }
}
