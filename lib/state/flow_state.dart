import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelf/utilities/user_prefs.dart';

class FlowState {
  PageController controller = PageController(initialPage: 0);

  int index = 0;

  StreamController<int> indexStream = StreamController.broadcast();

  goToQuickNote() async {
    if (!visible) {
      toggleVisibility();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    controller.page != 1
        ? controller.animateToPage(
            1,
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
          )
        : null;
  }

  String greetingText = "Double Tap.";
  StreamController<String> greetingTextStream = StreamController.broadcast();
  TextEditingController greetingTextController = TextEditingController();

  updateGreetingText(String term, {bool save = true}) async {
    greetingText = term;
    greetingTextStream.add(term);
    if (save) {
      await _saveGreetingText(term);
    }
  }

  _saveGreetingText(term) async {
    await userPrefs.setString(PrefKeys.greetingText, term);
  }

  final TextEditingController quickNoteController = TextEditingController();

  saveQuickNote(String term) async {
    await userPrefs.setString(PrefKeys.quickNoteText, term);
  }

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
    await userPrefs.setBool(PrefKeys.flowVisible, isVisible);
  }

  toggleVisibility() {
    updateVisibility(!visible);
  }
}
