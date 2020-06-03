import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request();
  await Permission.camera.request();
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
  var webView;

//demo.teacher@midade.com
//123456
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        body: InAppWebView(
          initialUrl: 'https://demo1.3lameni.com/ar',
          onWebViewCreated: (controller) async {
            print("Hello");
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            print(url);
          },
          androidOnPermissionRequest: (InAppWebViewController controller,
              String origin, List<String> resources) async {
            print(origin);
            print(resources);
            if(await Permission.microphone.isGranted && await Permission.camera.isGranted)
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT,
            );
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.DENY,
            );
          },
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              mediaPlaybackRequiresUserGesture: false,
              debuggingEnabled: true,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBack() async {
    bool goBack;
    // check webview can go back
    final value = await webView.canGoBack();
    if (value) {
      webView.goBack(); // perform webview back operation
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmation ', style: TextStyle(color: Colors.purple)),
          // Are you sure?
          content: Text('Do you want exit app ? '),
          // Do you want to go back?
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() => goBack = false);
              },
              child: new Text('No'), // No
            ),
            new FlatButton(
              onPressed: () {
                SystemNavigator.pop();
                setState(() => goBack = true);
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      );
      if (goBack) Navigator.pop(context); // If user press Yes pop the page
      print(goBack);
      return goBack;
    }
  }
}
