import 'package:flutter/material.dart';
import 'package:otrujja/Screens/home_screen.dart';
import 'package:otrujja/constants.dart';

class OtrujjaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: applicationTitle,
      home: HomeScreen(),
      locale: Locale('ar'),
    );
  }
}
