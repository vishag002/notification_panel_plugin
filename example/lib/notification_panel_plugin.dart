import 'package:flutter/services.dart';

class NotificationPanelPlugin {
  static const MethodChannel _channel =
      MethodChannel('notification_panel_plugin');

  static Future<bool> openNotificationPanel() async {
    try {
      await _channel.invokeMethod('openNotificationPanel');
      return true;
    } on PlatformException catch (e) {
      print("Failed to open notification panel: '${e.message}'.");
      return false;
    }
  }
}
