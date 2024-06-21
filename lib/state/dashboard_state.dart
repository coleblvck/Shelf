import 'dart:async';

import '../utilities/user_prefs.dart';

class DashboardState {
  bool visible = true;
  StreamController<bool> visibilityStream = StreamController.broadcast();

  updateVisibility(bool isVisible, {bool save = true}) async {
    visible = isVisible;
    visibilityStream.add(isVisible);
    if (save) {
      await _save(isVisible);
    }
  }

  _save(bool isVisible) async {
    await userPrefs.setBool(PrefKeys.dashboardVisible, isVisible);
  }

  toggleVisibility() {
    updateVisibility(!visible);
  }
}
