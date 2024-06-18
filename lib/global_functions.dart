import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/screens/desktop.dart';
import 'package:shelf/widgets/app_list.dart';
import 'package:shelf/widgets/Blinds.dart';
import 'package:shelf/widgets/boxes.dart';
import 'package:shelf/widgets/search.dart';

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
