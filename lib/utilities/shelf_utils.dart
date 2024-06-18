import 'dart:async';

import 'package:flutter/services.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:intl/intl.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';

getAppList() async {
  List<AppInfo> apps = await InstalledApps.getInstalledApps(
    true,
    true,
  );
  apps.sort(
    (a, b) => a.name.compareTo(b.name),
  );
  apps.removeWhere((app) => app.packageName == "com.coleblvck.shelf");
  allAppsListStream.add(apps);
  allAppsList = apps;
}

initAppList() async {
  await getAppList();
}

refreshShelf() async {
  updateRefreshProcess(true);
  await refreshColorScheme();
  await getAppList();
  updateRefreshProcess(false);
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  return DateFormat.jms().format(now);
}

bool systemUIShown = true;

toggleSystemUIMode() {
  !systemUIShown
      ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values)
      : SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  systemUIShown = !systemUIShown;
}

setSystemUIMode(bool mode) {
  mode
      ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values)
      : SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  systemUIShown = mode;
}

initShelf() async {
  await initColorScheme();
  await initAppList();
  setSystemUIMode(false);
}

bool firstBoxVisible = true;
StreamController<bool> firstBoxVisibilityStream = StreamController.broadcast();

updateFirstBoxVisibility(bool isVisible) {
  firstBoxVisible = isVisible;
  firstBoxVisibilityStream.add(isVisible);
}

toggleFirstBoxVisibility() {
  updateFirstBoxVisibility(!firstBoxVisible);
}

bool dashboardVisible = true;
StreamController<bool> dashboardVisibilityStream = StreamController.broadcast();

updateDashboardVisibility(bool isVisible) {
  dashboardVisible = isVisible;
  dashboardVisibilityStream.add(isVisible);
}

toggleDashboardVisibility() {
  updateDashboardVisibility(!dashboardVisible);
}

const MethodChannel platformChannel = MethodChannel('shelfChannel');

void expandNotificationBar() async {
  try {
    await platformChannel.invokeMethod('expandStatusBar');
  } catch (e) {
    null;
  }
}

bool isShelfRefreshing = false;
StreamController<bool> isShelfRefreshingStream = StreamController.broadcast();

updateRefreshProcess(bool value) {
  isShelfRefreshing = value;
  isShelfRefreshingStream.add(value);
}
