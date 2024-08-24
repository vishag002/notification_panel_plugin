package com.example.notification_panel_plugin

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NotificationPanelPlugin */
class NotificationPanelPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "notification_panel_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
package com.example.notification_panel_plugin

import android.content.Context
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class NotificationPanelPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "notification_panel_plugin")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "openNotificationPanel") {
      openNotificationPanel()
      result.success(null)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun openNotificationPanel() {
    try {
      when {
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
          val statusBarService = context.getSystemService(Context.STATUS_BAR_SERVICE)
          val statusBarManager = Class.forName("android.app.StatusBarManager")
          val method = statusBarManager.getMethod("expandNotificationsPanel")
          method.invoke(statusBarService)
        }
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.M -> {
          val statusBarService = context.getSystemService("statusbar")
          val statusBarManager = Class.forName("android.app.StatusBarManager")
          val method = statusBarManager.getMethod("expandNotificationsPanel")
          method.invoke(statusBarService)
        }
        else -> {
          @Suppress("DEPRECATION")
          val service = context.getSystemService(Context.NOTIFICATION_SERVICE) as android.app.NotificationManager
          val method = service.javaClass.getMethod("expandNotificationsPanel")
          method.invoke(service)
        }
      }
    } catch (e: Exception) {
      e.printStackTrace()
      Log.e("NotificationPanelPlugin", "Failed to open notification panel: ${e.message}")
    }
  }
}