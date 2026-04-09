import 'package:flutter/services.dart';

class ARService {
  static const platform = MethodChannel('ar_channel');

  static Future<void> openAR() async {
    await platform.invokeMethod('openAR');
  }
}