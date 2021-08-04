import 'package:flutter/material.dart';
import 'package:otrujja/Screens/otrujja_webview.dart';
import 'package:otrujja/constants.dart';

class OtrujjaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: applicationTitle,
      home: OtrujjaWebView(),
      locale: Locale('ar'),
    );
  }
}
