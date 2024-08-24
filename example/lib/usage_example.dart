import 'package:notification_panel_plugin/notification_panel_plugin.dart';

// ...

GestureDetector(
  onVerticalDragEnd: (details) async {
    if (details.primaryVelocity! > 0) {
      // Drag down: Open notification panel
      print("Vertical drag ended: Drag down detected, opening notification panel.");
      try {
        await NotificationPanelPlugin.openNotificationPanel();
      } catch (e) {
        print("Error opening notification panel: $e");
      }
    }
    // ... other gesture handling
  },
  // ... rest of your GestureDetector
)