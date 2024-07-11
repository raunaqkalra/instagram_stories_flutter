import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  final String url;

  const Webview({super.key, required this.url});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  late WebViewController controller;

  @override
  void initState() {
    // if (!widget.url.contains('http')) {
    //   widget.url = 'https://${widget.url}';
    // }
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
          onHttpError: (HttpResponseError error) {},
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}
