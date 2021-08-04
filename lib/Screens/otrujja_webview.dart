import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class OtrujjaWebView extends StatefulWidget {
  @override
  _OtrujjaWebViewState createState() => _OtrujjaWebViewState();
}

class _OtrujjaWebViewState extends State<OtrujjaWebView> {
  final String _url = "https://demo1.3lameni.com/ar";
  late InAppWebViewController webView;
  int _page = 1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack as Future<bool> Function()?,
      child: Scaffold(
        body: IndexedStack(
          index: _page,
          children: <Widget>[
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(_url)),
              onWebViewCreated: (controller) async {
                webView = controller;
              },
              onLoadResource:
                  (InAppWebViewController controller, LoadedResource resource) {
                if (resource.url.toString().contains('zoom')) {
                  _launchURL(resource);
                }
              },
              onLoadStop: (InAppWebViewController controller, Uri? resource) {
                setState(() => _page = 0);
              },
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                print(origin);
                print(resources);
                if (await Permission.microphone.isGranted &&
                    await Permission.camera.isGranted)
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  ); //
                return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.DENY,
                );
              },
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                ),
              ),
            ),
            _spinner()
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _spinner() {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool?> _onBack() async {
    bool? goBack;
    // check webview can go back
    final _value = await webView.canGoBack();
    if (_value) {
      webView.goBack(); // perform webview back operation
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('تأكيد ', style: _textStyle(color: Colors.purple)),
          // Are you sure?
          content: Text(
            'هل تود إغلاق التطبيق؟ ',
            style: _textStyle(),
          ),
          // Do you want to go back?
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() => goBack = false);
              },
              child: Text(
                'لا',
                style: _textStyle(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
                setState(() => goBack = true);
              },
              child: Text(
                'نعم',
                style: _textStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
      if (goBack!) Navigator.pop(context); // If user press Yes pop the page

      return goBack;
    }
  }

  TextStyle _textStyle({color = Colors.black}) {
    return TextStyle(color: color, fontFamily: 'tajawal', fontSize: 19);
  }
}
