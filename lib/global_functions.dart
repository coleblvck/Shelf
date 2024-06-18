import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:shelf/screens/desktop.dart';

toggleMenu() {
  secondBoxController.page == 1
      ? secondBoxController.animateToPage(
          0,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 300),
        )
      : secondBoxController.animateToPage(
          1,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 300),
        );
}

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
