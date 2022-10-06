import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semantic_announcement_tester/semantic_announcement_tester.dart';

import 'test_app.dart';

void main() {
  testWidgets('Zero announcements', (WidgetTester tester) async {
    final mock = MockSemanticAnnouncements(tester);
    await tester.pumpWidget(const TestApp());

    expect(mock.announcements, hasZeroAnnouncements());
  });

  testWidgets('One announcement', (WidgetTester tester) async {
    final mock = MockSemanticAnnouncements(tester);
    const expectedAnnouncement = AnnounceSemanticsEvent(
      "Announcement made",
      TextDirection.ltr,
    );
    await tester.pumpWidget(const TestApp());

    // Tap to trigger an announcement
    await tester.tap(find.byType(ElevatedButton));

    expect(
      mock.announcements,
      hasOneAnnouncement(expectedAnnouncement),
    );
  });

  testWidgets('N announcements', (WidgetTester tester) async {
    final mock = MockSemanticAnnouncements(tester);
    const expectedAnnouncement = AnnounceSemanticsEvent(
      "Announcement made",
      TextDirection.ltr,
    );
    await tester.pumpWidget(const TestApp());

    // Tap twice to trigger two announcements
    await tester.tap(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));

    expect(
      mock.announcements,
      hasNAnnouncements([expectedAnnouncement, expectedAnnouncement]),
    );
  });
}
