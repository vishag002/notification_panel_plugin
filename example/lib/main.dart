import 'package:flutter/material.dart';
import 'package:notification_panel_plugin/notification_panel_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Panel Plugin Example'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Open Notification Panel'),
            onPressed: () async {
              await NotificationPanelPlugin.openNotificationPanel();
            },
          ),
        ),
      ),
    );
  }
}
