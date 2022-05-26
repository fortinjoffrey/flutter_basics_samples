import 'package:basics_samples/empty_view.dart';
import 'package:basics_samples/main.dart';
import 'package:flutter/material.dart';

class BView extends StatefulWidget {
  const BView({Key? key}) : super(key: key);

  @override
  State<BView> createState() => _BViewState();
}

class _BViewState extends State<BView> with RouteAware {
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // NOTE: This is called once the popping animation is finished
    print('dispose called');
    bRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPop() {
    // Called when the current route has been popped off.
    // NOTE: This is called before the popping animation
    print('didPop called');
    super.didPop();
  }

  @override
  void didPush() {
    // Called when the current route has been pushed.
    // NOTE: This is called before the pushing animation
    print('didPush called');
    super.didPush();
  }

  @override
  void didPopNext() {
    // Called when the top route has been popped off, and the current route shows up
    // NOTE: This is called before the popping animation of stacked view
    print('didPopNext called');
    super.didPopNext();
  }

  @override
  void didPushNext() {
    // Called when a new route has been pushed, and the current route is no longer visible.
    // NOTE: This is called before the pushing animation of pushed view
    print('didPushNext called');
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B view'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EmptyView(),
                  ),
                );
              },
              child: const Text('Push empty view'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Pop view'),
            ),
          ],
        ),
      ),
    );
  }
}
