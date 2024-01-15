import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewMovie extends StatefulWidget {
  String url;
  webViewMovie({super.key, required this.url});

  @override
  State<webViewMovie> createState() => _webViewMovieState();
}

class _webViewMovieState extends State<webViewMovie> {
  var controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
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
    return SizedBox(
      height: 220,
      child: Container(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
