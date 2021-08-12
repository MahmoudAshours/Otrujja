import 'dart:convert';

import 'package:flutter/services.dart';

class GetJsonData {
  static Future myLoadAsset(String path) async {
    print('HELLO');
    try {
      final data = await rootBundle.loadString(path);
      print(json.decode(data));
      return json.decode(data);
    } catch (_) {
      print('object');
    }
  }
}
