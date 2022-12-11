import 'package:basics_samples/models.dart';

class ApiSource {
  Future<Event> getEvent(String eventId) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (eventId == '0') {
      return _getEventWithoutSelectedDates();
    } else if (eventId == '1') {
      return _getEventWithOneSelectedDates();
    }
    return _getEventWithTwoSelectedDates();
  }

  Event _getEventWithoutSelectedDates() {
    return Event(
      proposedDates: [
        EventDate(date: DateTime(2023, 12, 01)),
        EventDate(date: DateTime(2023, 12, 03)),
        EventDate(date: DateTime(2023, 12, 05)),
      ],
      participants: <Participant>{
        Participant(
          info: const ParticipantInfo(id: '1', name: 'James'),
          availableDates: <DateTime>{
            DateTime(2023, 12, 01),
            DateTime(2023, 12, 03),
          },
        ),
        Participant(
          info: const ParticipantInfo(id: '2', name: 'Harry'),
          availableDates: <DateTime>{
            DateTime(2023, 12, 03),
            DateTime(2023, 12, 05),
          },
        )
      },
      name: 'Event with no selected dates',
    );
  }

  Event _getEventWithOneSelectedDates() {
    return Event(
      proposedDates: [
        EventDate(
          date: DateTime(2023, 12, 01),
        ),
        EventDate(
          date: DateTime(2023, 12, 03),
          state: EventDateState.selected,
        ),
        EventDate(date: DateTime(2023, 12, 05)),
      ],
      participants: <Participant>{
        Participant(
          info: const ParticipantInfo(id: '1', name: 'James'),
          availableDates: <DateTime>{
            DateTime(2023, 12, 01),
            DateTime(2023, 12, 03),
          },
        ),
        Participant(
          info: const ParticipantInfo(id: '2', name: 'Harry'),
          availableDates: <DateTime>{
            DateTime(2023, 12, 03),
            DateTime(2023, 12, 05),
          },
        )
      },
      name: 'Event with no selected dates',
    );
  }

  Event _getEventWithTwoSelectedDates() {
    return Event(
      proposedDates: [
        EventDate(
          date: DateTime(2023, 12, 01),
        ),
        EventDate(
          date: DateTime(2023, 12, 03),
          state: EventDateState.selected,
        ),
        EventDate(
          date: DateTime(2023, 12, 05),
          state: EventDateState.selected,
        ),
      ],
      participants: <Participant>{
        Participant(
          info: const ParticipantInfo(id: '1', name: 'James'),
          availableDates: <DateTime>{
            DateTime(2023, 12, 01),
            DateTime(2023, 12, 03),
          },
        ),
        Participant(
          info: const ParticipantInfo(id: '2', name: 'Harry'),
          availableDates: <DateTime>{
            DateTime(2023, 12, 03),
            DateTime(2023, 12, 05),
          },
        )
      },
      name: 'Event with no selected dates',
    );
  }
}
