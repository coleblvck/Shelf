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
      ? secondBoxController.jumpToPage(0)
      : secondBoxController.jumpToPage(1);
}

search(term) {
  if (menuShown) {
    toggleMenu();
  }
  if (searchController.text != "") {
    desktopBox2Child = SearchBuilder(
      term: term,
    );
  } else {
    desktopBox2Child = Container();
  }
}

launchApp(String appToLaunch) async {
  try {
    bool? success = await InstalledApps.startApp(appToLaunch);
    print(success);
  } catch (e) {
    null;
  }
}
