

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViews extends StatefulWidget {
  final String? title;
  final String url;
  const WebViews({Key? key, this.title, required this.url}) : super(key: key);

  @override
  State<WebViews> createState() => _WebViewsState();
}

class _WebViewsState extends State<WebViews> {
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions settings = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: true,
      ),
      android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
          overScrollMode: AndroidOverScrollMode.OVER_SCROLL_ALWAYS
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final ValueNotifier<String> title = ValueNotifier('');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.value = widget.title ?? '';
    url = widget.url;
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.red,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, Widget? child) {
            return Text(value);
          },
        ),
      ),
      body: Column(
        children: [
          progress < 1.0
              ? SizedBox(
              height: 1,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 1,
              ))
              : Container(),
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse(url)),
              initialOptions: settings,
              gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                });
              },
              onTitleChanged: (c,v){
                if(widget.title==null){
                  title.value = v??'';
                }

              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                  // if (await canLaunch(url)) {
                  //   // Launch the App
                  //   await launch(
                  //     url,
                  //   );
                  //   // and cancel the request
                  //   return NavigationActionPolicy.CANCEL;
                  // }
                }

                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  this.url = url.toString();
                });
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
          ),
        ],
      ),
    );
  }
}
