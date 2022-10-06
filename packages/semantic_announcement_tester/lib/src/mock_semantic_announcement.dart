import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semantic_announcement_tester/semantic_announcement_tester.dart';

/// Registers a mock message handler using
/// [TestDefaultBinaryMessenger.setMockDecodedMessageHandler] to allow testing
/// semantic announcements made using [SemanticsService.announce].
///
/// Useful with [hasNAnnouncements], [hasZeroAnnouncements] or
/// [hasOneAnnouncement].
class MockSemanticAnnouncements {
  final _messages = <AnnounceSemanticsEvent>[];

  /// Tracks all the announcements made.
  List<AnnounceSemanticsEvent> get announcements => _messages;

  MockSemanticAnnouncements(WidgetTester tester) {
    _setMockMessageHandler(tester);
  }

  void _setMockMessageHandler(WidgetTester tester) {
    Future<dynamic> handleMessage(mockMessage) async {
      final message = mockMessage as Map<dynamic, dynamic>;
      if (message['type'] == 'announce') {
        _messages.add(
          AnnounceSemanticsEvent(
            message['data']['message'],
            TextDirection.values[message['data']['textDirection']],
          ),
        );
      }
    }

    tester.binding.defaultBinaryMessenger.setMockDecodedMessageHandler<dynamic>(
        SystemChannels.accessibility, handleMessage);
  }
}
