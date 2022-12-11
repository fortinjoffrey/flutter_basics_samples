import 'package:flutter/material.dart';
import 'package:basics_samples/event_dates/event_dates_widget_store.dart';
import 'package:basics_samples/models.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

enum EventDateMode { preview, selection, previewPostSelection }

class EventDatesWidget extends StatefulWidget {
  const EventDatesWidget({
    super.key,
    required this.eventDates,
    required this.mode,
    required this.onEventDatesChanged,
  });

  final List<EventDate> eventDates;
  final EventDateMode mode;
  final ValueChanged<List<EventDate>>? onEventDatesChanged;

  @override
  State<EventDatesWidget> createState() => _EventDatesWidgetState();
}

class _EventDatesWidgetState extends State<EventDatesWidget> {
  late final EventDatesWidgetStore _store;
  late final ReactionDisposer _reactionDisposer;

  @override
  void initState() {
    super.initState();
    _store = EventDatesWidgetStore(eventDates: widget.eventDates, mode: widget.mode);

    _reactionDisposer = reaction<ObservableList<EventDate>>(
      (_) => _store.eventDates,
      (eventDates) {
        widget.onEventDatesChanged?.call(eventDates);
      },
    );
  }

  @override
  void didUpdateWidget(covariant EventDatesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) {
      _store.mode = widget.mode;
    }
  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final eventDates = _store.eventDates;
      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _EventDateCell(
              eventDate: eventDates.elementAt(index),
              onTap: () => _store.onEventDateTapped(index),
            );
          },
          itemCount: widget.eventDates.length,
        ),
      );
    });
  }
}

class _EventDateCell extends StatelessWidget {
  const _EventDateCell({
    Key? key,
    required this.eventDate,
    required this.onTap,
  }) : super(key: key);

  final EventDate eventDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final EventDateState state = eventDate.state;
    final DateTime date = eventDate.date;

    final formattedDate = DateFormat('E dd MMM').format(date);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _getBorderColorForState(state), width: 3),
            color: _getBackgroundColorForState(state),
          ),
          child: Center(child: Text(formattedDate.toString())),
          // child: Center(child: Text('${date.month}/${date.day}')),
        ),
      ),
    );
  }

  Color _getBorderColorForState(EventDateState state) {
    switch (state) {
      case EventDateState.unselected:
      case EventDateState.selected:
        return Colors.black;
      case EventDateState.previewed:
      case EventDateState.selectedPreviewed:
        return Colors.blue;
    }
  }

  Color _getBackgroundColorForState(EventDateState state) {
    switch (state) {
      case EventDateState.unselected:
      case EventDateState.previewed:
        return Colors.white;
      case EventDateState.selected:
      case EventDateState.selectedPreviewed:
        return Colors.green;
    }
  }
}
