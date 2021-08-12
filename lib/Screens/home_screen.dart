import 'package:flutter/material.dart';
import 'package:otrujja/Helpers/getJson_data.dart';
import 'package:otrujja/Screens/Quiz/otrujja_quizscreen.dart';
import 'package:otrujja/Screens/otrujja_webview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? _screens;
  int _navigationIndex = 0;

  @override
  void initState() {
    GetJsonData.myLoadAsset('assets/tagweed.json').then(
      (value) => setState(
        () {
          _screens =
              List.unmodifiable([OtrujjaWebView(), OtrujjaQuiz(quiz: value)]);
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens == null
          ? Center(child: CircularProgressIndicator())
          : _screens![_navigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationIndex,
        onTap: (newIndex) => setState(() => _navigationIndex = newIndex),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            label: 'تصفح',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'اختبر نفسك'),
        ],
      ),
    );
  }
}
