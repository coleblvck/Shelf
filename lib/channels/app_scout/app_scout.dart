import 'package:flutter/services.dart';
import 'package:shelf/state/state_util.dart';

import 'app_detail.dart';

class AppScout {
  static const MethodChannel channel = MethodChannel("appScoutChannel");

  static Future<List<AppDetail>> fetchApps() async {
    dynamic apps = await channel.invokeMethod(
      "fetchApps",
    );
    return AppDetail.parseList(apps);
  }

  static Future<bool?> launchApp(String packageName) async {
    return channel.invokeMethod(
      "launchApp",
      {"packageName": packageName},
    );
  }

  static openAppSettings(String packageName) {
    channel.invokeMethod(
      "openAppSettings",
      {"packageName": packageName},
    );
  }

  static Future<bool?> uninstallApp(String packageName) async {
    return channel.invokeMethod(
      "uninstallApp",
      {"packageName": packageName},
    );
  }

  static const EventChannel eventChannel = EventChannel("scoutUpdateChannel");
  static initScoutListen() {
    eventChannel.receiveBroadcastStream().listen(_onEvent);
  }

  static void _onEvent(Object? event) {
    shelfState.refreshShelf();
  }
}
