import 'package:flutter/services.dart';
import 'package:shelf/utilities/app_scout/app_detail.dart';

class AppScout {
  static const MethodChannel channel = MethodChannel("appScoutChannel");

  static Future<List<AppDetail>> fetchApps([
    bool includeSystemApps = false,
    bool includeAppIcons = true,
  ]) async {
    dynamic apps = await channel.invokeMethod(
      "fetchApps",
      {
        "includeSystemApps": includeSystemApps,
        "includeAppIcons": includeAppIcons,
      },
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
}
