import 'dart:async';

import '../utilities/user_prefs.dart';

class DrawerState {
  String layout = DrawerLayout.woven;
  StreamController<String> layoutStream = StreamController.broadcast();

  updateLayout(String state, {bool save = true}) async {
    layout = state;
    layoutStream.add(state);
    if (save) {
      await _save(state);
    }
  }

  _save(String state) async {
    await userPrefs.setString(PrefKeys.drawerLayout, state);
  }
}

class DrawerLayout {
  static String woven = "Woven";
  static String boxes = "Boxes";
  static String blinds = "Blinds";
}
