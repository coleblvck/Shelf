import 'package:installed_apps/installed_apps.dart';

launchApp(String appToLaunch) async {
  try {
    await InstalledApps.startApp(appToLaunch);
  } catch (e) {
    null;
  }
}

openAppSettings(String packageName) async {
  InstalledApps.openSettings(packageName);
}
