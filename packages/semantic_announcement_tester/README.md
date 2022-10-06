This package provides a set of matchers that make testing semantic announcements made using
`SemanticsService.announce` dead simple.

## Installing
This package is to be used only for tests. Add it to pubspec under dev_dependencies like:
```yaml
dev_dependencies:
   semantic_announcement_tester: ^{version}
```

## Usage

1. Create an object for `MockSemanticAnnouncements` in your widget test.
2. Write the test code as usual, in the following examples we assume that tapping the button triggers a Semantics
   Announcement.
3. Use one of the matchers from: `hasOneAnnouncement`, `hasNAnnouncements` or `hasZeroAnnouncements` to assert.

To test one announcement:
```dart
  testWidgets('One announcement', (WidgetTester tester) async {
    final mock = MockSemanticAnnouncements(tester);
    const expectedAnnouncement = AnnounceSemanticsEvent(
      "Announcement made",
      TextDirection.ltr,
    );
    await tester.pumpWidget(const MyApp());

    // Tap to trigger an announcement
    await tester.tap(find.byType(ElevatedButton));

    expect(
      mock.announcements,
      hasOneAnnouncement(expectedAnnouncement),
    );
  });
```

To test N announcements made:
```dart
testWidgets('N announcements', (WidgetTester tester) async {
    final mock = MockSemanticAnnouncements(tester);
    const expectedAnnouncement = AnnounceSemanticsEvent(
      "Announcement made",
      TextDirection.ltr,
    );
    await tester.pumpWidget(const MyApp());

    // Tap twice to trigger two announcements
    await tester.tap(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));

    expect(
      mock.announcements,
      hasNAnnouncements([expectedAnnouncement, expectedAnnouncement]),
    );
  });
```

To test zero announcements made:
```dart
testWidgets("Zero announcements", (WidgetTester tester) async {
  final mock = MockSemanticAnnouncements(tester);
  await tester.pumpWidget(const MyApp());

  expect(mock.announcements, hasZeroAnnouncements());
});
```

## Additional information

Internally, creating an object for `MockSemanticAnnouncements` sets mock message handler for accessibility platform
channel which is used by `SemanticsService.announce` to deliver the announcement to the OS. This class intercepts these
messages and stores them as a list of `AnnounceSemanticsEvent`, which can be used for assertion.

Finally, the matchers make it very simple to assert in tests without having to deal with the implementation details of
`SemanticService.announce` method.

## Note

There is room for improvement in the matcher to provide more concise error messages when a test fails. This will improve
in subsequent versions.