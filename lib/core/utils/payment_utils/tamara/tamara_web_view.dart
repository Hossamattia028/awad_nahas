import 'dart:async';

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class TamaraCheckout extends StatefulWidget {
  final String checkoutUrl;
  final String successUrl;
  final String failUrl;
  final String cancelUrl;


  const TamaraCheckout(this.checkoutUrl, this.successUrl, this.failUrl, this.cancelUrl, {Key? key,
    this.onPaymentSuccess, this.onPaymentFailed, this.onPaymentCanceled}) : super(key: key);

  final void Function()? onPaymentSuccess;
  final void Function()? onPaymentFailed;
  final void Function()? onPaymentCanceled;
  // final TamaraInAppBrowser browser = TamaraInAppBrowser();

  @override
  TamaraCheckoutState createState() => TamaraCheckoutState();

}

class TamaraCheckoutState extends State<TamaraCheckout> {

  // late InAppWebViewController _webViewController;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

// set a HTTP auth credential for a particular Protection Space


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: const GlobalAppBar(
        title: "",
        leadingIcon: BackArrowButton(),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          navigationDelegate: (NavigationRequest request) {
            String url = request.url;
            if (url.startsWith(widget.successUrl)) {
              if (widget.onPaymentSuccess != null) {
                widget.onPaymentSuccess!();
                return NavigationDecision.prevent;
              }
            } else if (url.startsWith(widget.failUrl)) {
              if (widget.onPaymentFailed != null) {
                widget.onPaymentFailed!();
                return NavigationDecision.prevent;
              }
            } else if (url.startsWith(widget.cancelUrl)) {
              if (widget.onPaymentCanceled != null) {
                widget.onPaymentCanceled!();
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;

          },
          onPageStarted: (String url) {

          },
          onPageFinished: (String url) {
            debugPrint("finished: $url");
            if(url.contains("successful")){
              Navigator.of(context).pop("successful");
            }else if(url.contains("canceled")){
              Navigator.of(context).pop("canceled");
            }
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        );
      }),
    );
  }

}
