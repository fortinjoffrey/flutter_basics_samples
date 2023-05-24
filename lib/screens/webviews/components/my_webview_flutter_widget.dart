import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebviewFlutterWidget extends StatefulWidget {
  const MyWebviewFlutterWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<MyWebviewFlutterWidget> createState() => _MyWebviewFlutterWidgetState();
}

class _MyWebviewFlutterWidgetState extends State<MyWebviewFlutterWidget> {
  late WebViewController _webViewController;

  @override
  void didUpdateWidget(covariant MyWebviewFlutterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.url != widget.url) {
      _webViewController.loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      key: UniqueKey(),
      controller: _webViewController,
    );
  }
}
