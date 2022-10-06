import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

/// Verifies if only one semantic announcement was made.
Matcher hasOneAnnouncement(AnnounceSemanticsEvent event) {
  return _HasSemanticsAnnouncementMatcher([event]);
}

/// Verifies if N semantic announcements were made. The order of events is
/// important.
Matcher hasNAnnouncements(List<AnnounceSemanticsEvent> events) {
  return _HasSemanticsAnnouncementMatcher(events);
}

/// Verifies if no semantic announcements were made.
Matcher hasZeroAnnouncements() {
  return const _HasSemanticsAnnouncementMatcher([]);
}

class _HasSemanticsAnnouncementMatcher extends Matcher {
  const _HasSemanticsAnnouncementMatcher(this.expectedEvents);

  final List<AnnounceSemanticsEvent> expectedEvents;

  @override
  bool matches(covariant List<AnnounceSemanticsEvent> events,
      Map<dynamic, dynamic> matchState) {
    if (expectedEvents.length != events.length) {
      return false;
    }
    for (int i = 0; i < expectedEvents.length; i++) {
      if (!mapEquals(expectedEvents[i].getDataMap(), events[i].getDataMap())) {
        return false;
      }
    }
    return true;
  }

  @override
  Description describe(Description description) {
    if (expectedEvents.isEmpty) {
      return description.add("Zero announcements");
    }
    return description.add(expectedEvents.toString());
  }
}
