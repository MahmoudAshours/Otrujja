import 'package:flutter/material.dart';
import 'package:otrujja/otruja_app.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.microphone.request();
  await Permission.camera.request();
  runApp(OtrujjaApp());
}
