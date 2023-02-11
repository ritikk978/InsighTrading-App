import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart' hide WebView;

class TradingViewPage extends StatefulWidget {
  final String symbol;
  TradingViewPage({Key? key, required this.symbol}) : super(key: key);

  @override
  State<TradingViewPage> createState() => _TradingViewPageState();
}

class _TradingViewPageState extends State<TradingViewPage> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Live, Crypto, Stocks and Forex')),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: HtmlWidget(
            '<iframe src="https://www.tradingview.com/chart/?symbol=${widget.symbol}&interval=15"></iframe>',
            factoryBuilder: () => MyWidgetFactory(),
          ),
        ));
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {
  bool get webViewMediaPlaybackAlwaysAllow => true;
  String? get webViewUserAgent => 'app';
}
