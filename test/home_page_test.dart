import 'package:basics_samples/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semantic_announcement_tester/semantic_announcement_tester.dart';

void main() {
  group('Announcements tests', () {
    testWidgets('Zero announcement', (WidgetTester tester) async {
      // sets mock message handler for accessibility platform channel which 
      // is used by SemanticsService.announce to deliver the announcement to the OS
      final mock = MockSemanticAnnouncements(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      final button = find.byKey(Key('one'));

      await tester.tap(button);

      await tester.pump();

      expect(mock.announcements, hasZeroAnnouncements());
    });
    testWidgets('One announcement', (WidgetTester tester) async {
      final mock = MockSemanticAnnouncements(tester);

      const expectedAnnouncement = AnnounceSemanticsEvent('Hello there', TextDirection.ltr);

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      final button = find.byKey(Key('two'));

      await tester.tap(button);

      await tester.pump();

      expect(mock.announcements, hasOneAnnouncement(expectedAnnouncement));
    });
  });

  testWidgets('One announcement', (WidgetTester tester) async {
    final mock = MockSemanticAnnouncements(tester);
    const firstAnnouncement = AnnounceSemanticsEvent('Fetching data', TextDirection.ltr);
    const secondAnnouncement = AnnounceSemanticsEvent('Data fetched', TextDirection.ltr);

    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    final button = find.byKey(Key('three'));

    await tester.tap(button);

    await tester.pumpAndSettle();

    expect(
      mock.announcements,
      hasNAnnouncements([firstAnnouncement, secondAnnouncement]),
    );
  });
}
