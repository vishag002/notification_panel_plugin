import 'package:flutter_test/flutter_test.dart';
import 'package:notification_panel_plugin/notification_panel_plugin.dart';
import 'package:notification_panel_plugin/notification_panel_plugin_platform_interface.dart';
import 'package:notification_panel_plugin/notification_panel_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNotificationPanelPluginPlatform
    with MockPlatformInterfaceMixin
    implements NotificationPanelPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NotificationPanelPluginPlatform initialPlatform = NotificationPanelPluginPlatform.instance;

  test('$MethodChannelNotificationPanelPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNotificationPanelPlugin>());
  });

  test('getPlatformVersion', () async {
    NotificationPanelPlugin notificationPanelPlugin = NotificationPanelPlugin();
    MockNotificationPanelPluginPlatform fakePlatform = MockNotificationPanelPluginPlatform();
    NotificationPanelPluginPlatform.instance = fakePlatform;

    expect(await notificationPanelPlugin.getPlatformVersion(), '42');
  });
}
