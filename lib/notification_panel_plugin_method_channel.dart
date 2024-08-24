import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'notification_panel_plugin_platform_interface.dart';

/// An implementation of [NotificationPanelPluginPlatform] that uses method channels.
class MethodChannelNotificationPanelPlugin extends NotificationPanelPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('notification_panel_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
