
import 'package:flutter/material.dart';
import 'package:otrujja/Screens/otrujja_webview.dart';

class OtrujjaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otrujja',
      home: OtrujjaWebView(),
      locale: Locale('ar'), 
    );
  }
}