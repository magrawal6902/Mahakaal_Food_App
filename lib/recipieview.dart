import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class RecipieView extends StatefulWidget {

String url;
RecipieView(this.url);
  @override
  State<RecipieView> createState() => _RecipieViewState();
}

class _RecipieViewState extends State<RecipieView> {
  late String FinalUrl;
  final Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  void initState() {
    if(widget.url.toString().contains("http://")){
      FinalUrl = widget.url.toString().replaceAll("http://", "https://");
    }
    else{
      FinalUrl = widget.url;
    }

    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Food Recipie App"),
      ),
      body: Container(
        child: WebView(
          initialUrl: FinalUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              controller.complete((webViewController));
            });
          },
        )
      ),
    );
  }
}