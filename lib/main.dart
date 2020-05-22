import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otrujja',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EasyWebView(
      src: 'https://demo1.3lameni.com/ar',
      isHtml: false, // Use Html syntax
      webAllowFullScreen: true,
      isMarkdown: false, // Use markdown syntax
      convertToWidets: false, // Try to convert to flutter widgets
      // width: 100,
      // height: 100,
    ));
  }
}
