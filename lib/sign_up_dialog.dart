import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/router.dart';

enum SignUpSteps {
  email,
  name,
  adress,
}

class SignUpDialog extends StatefulWidget {
  final SignUpSteps? initialStep;

  const SignUpDialog({
    super.key,
    this.initialStep = SignUpSteps.email,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SignUpDialogState createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final PageController _pageController = PageController();
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialStep?.index ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_currentPage);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 600,
        height: 600,
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
            // _pageController.jumpTo(page.toDouble());
          },
          children: [
            // Add your pages here
            Container(
              color: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Page 1'),
                    ElevatedButton(
                      onPressed: () {
                        _pageController.animateToPage(
                          _currentPage + 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.green,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Page 2'),
                    ElevatedButton(
                      onPressed: () {
                        // _pageController.animateToPage(
                        //   _currentPage + 1,
                        //   duration: const Duration(milliseconds: 400),
                        //   curve: Curves.easeInOut,
                        // );
                        Navigator.of(context).pop();
                        const DetailsRoute(
                          itemId: '1',
                          itemName: 'Name 1',
                          isFavorite: true,
                          shoudShowDialog: true,
                          initialSignUpStep: SignUpSteps.adress,
                        ).go(context);
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.red,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Page 3'),
                    ElevatedButton(
                      onPressed: () {
                        // dismiss dialog
                        Navigator.of(context).pop();
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
