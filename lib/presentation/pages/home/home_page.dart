import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:basics_samples/presentation/pages/event/event_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const EventPage(eventId: '0',),
                    ),
                  );
                },
                child: const Text('Event with no selectioned dates'),
              ),
              ElevatedButton(
                onPressed: () {
                   Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const EventPage(eventId: '1',),
                    ),
                  );
                },
                child: const Text('Event with 1 date selected'),
              ),
              ElevatedButton(
                onPressed: () {
                   Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const EventPage(eventId: '2',),
                    ),
                  );
                },
                child: const Text('Event with 2 dates selected'),
              ),
            ],
          ),
        ));
  }
}
