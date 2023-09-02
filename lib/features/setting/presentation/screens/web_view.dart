import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;
  const WebViewScreen({Key? key,required this.title,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
        initialUrl: url,
    );
  }
}
