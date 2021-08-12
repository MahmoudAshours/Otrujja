import 'dart:convert';

import 'package:flutter/services.dart';

class GetJsonData {
  static Future myLoadAsset(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      return json.decode(data);
    } catch (_) {
      print('object');
    }
  }
}
