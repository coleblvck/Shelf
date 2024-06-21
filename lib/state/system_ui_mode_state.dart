import 'package:flutter/services.dart';

import '../utilities/user_prefs.dart';

class SystemUiDisplayState {
  bool shown = false;
  toggleUIMode() {
    setSystemUIMode(!shown);
  }

  setSystemUIMode(bool mode, {bool save = true}) async {
    mode
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values)
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    shown = mode;
    if (save) {
      await _save(mode);
    }
  }

  _save(bool mode) async {
    await userPrefs.setBool(PrefKeys.systemUiVisible, mode);
  }
}
