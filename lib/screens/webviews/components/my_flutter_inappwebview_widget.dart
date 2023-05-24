import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyFlutterInappwebviewWidget extends StatelessWidget {
  const MyFlutterInappwebviewWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      key: UniqueKey(),
      initialUrlRequest: URLRequest(url: Uri.parse(url)),
    );
  }
}


// InAppWebView(
//           onReceivedServerTrustAuthRequest: (controller, challenge) async {
//             return ServerTrustAuthResponse(
//               action: ServerTrustAuthResponseAction.PROCEED,
//             );
//           },
//           initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
//           initialOptions: InAppWebViewGroupOptions(
//             crossPlatform: InAppWebViewOptions(
//               javaScriptCanOpenWindowsAutomatically: true,
//               cacheEnabled: true,
//               useOnDownloadStart: true,
//               allowUniversalAccessFromFileURLs: true,
//               allowFileAccessFromFileURLs: true,
//               supportZoom: false,
//               javaScriptEnabled: true,
//             ),
//             android: AndroidInAppWebViewOptions(
//               domStorageEnabled: true,
//               allowContentAccess: true,
//               databaseEnabled: true,
//               networkAvailable: true,
//               allowFileAccess: true,
//             ),
//           ),
//           onWebViewCreated: (InAppWebViewController controller) {
//             webView = controller;
//           },
//         ),
//       ),