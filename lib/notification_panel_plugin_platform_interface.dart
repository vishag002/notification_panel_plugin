import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'notification_panel_plugin_method_channel.dart';

abstract class NotificationPanelPluginPlatform extends PlatformInterface {
  /// Constructs a NotificationPanelPluginPlatform.
  NotificationPanelPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NotificationPanelPluginPlatform _instance = MethodChannelNotificationPanelPlugin();

  /// The default instance of [NotificationPanelPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNotificationPanelPlugin].
  static NotificationPanelPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NotificationPanelPluginPlatform] when
  /// they register themselves.
  static set instance(NotificationPanelPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
