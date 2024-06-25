import 'dart:async';

import '../utilities/user_prefs.dart';

enum ParallaxStatus { falling, off }

class ParallaxState {
  ParallaxStatus status = ParallaxStatus.off;
  StreamController<ParallaxStatus> statusStream = StreamController.broadcast();

  setStatus(ParallaxStatus value, {bool save = true}) async {
    status = value;
    statusStream.add(value);
    if (save) {
      await _save(value);
    }
  }

  _save(ParallaxStatus value) async {
    bool toSave = value == ParallaxStatus.off ? false : true;
    await userPrefs.setBool(PrefKeys.parallaxStatus, toSave);
  }

  toggleStatus() {
    switch (status) {
      case ParallaxStatus.off:
        setStatus(ParallaxStatus.falling);
      case ParallaxStatus.falling:
        setStatus(ParallaxStatus.off);
    }
  }
}
