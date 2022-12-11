import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final List<EventDate> proposedDates;
  final Set<Participant> participants;

  const Event({required this.proposedDates, required this.participants, required this.name});

  @override
  List<Object?> get props => [name, proposedDates, participants];
}

class Participant extends Equatable {
  final ParticipantInfo info;
  final Set<DateTime> availableDates;

  const Participant({required this.info, required this.availableDates});

  @override
  List<Object?> get props => [info, availableDates];
}

class ParticipantInfo extends Equatable {
  final String id;
  final String name;

  const ParticipantInfo({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

enum EventDateState { unselected, previewed, selected, selectedPreviewed }

class EventDate extends Equatable {
  final EventDateState state;
  final DateTime date;

  const EventDate({
    this.state = EventDateState.unselected,
    required this.date,
  });

  @override
  List<Object?> get props => [state, date];
}