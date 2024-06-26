import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shelf/utilities/user_prefs.dart';
import 'package:shelf/ui/flow/flow.dart';

class FlowState {
  int initialPage = 4;
  int itemCount = 9;
  late int cardCount;
  late int currentIndex;
  late PageController controller;
  StreamController<int> indexStream = StreamController.broadcast();
  List<Widget> cards = const [
    HeaderCard(),
    NoteCard(),
  ];

  init() {
    currentIndex = initialPage;
    controller = PageController(initialPage: initialPage);
    cardCount = cards.length;
  }

  onPageChanged(int index) {
    currentIndex = index;
    indexStream.add(index);
  }

  goToQuickNote() async {
    if (!visible) {
      await toggleVisibility();
      //await Future.delayed(const Duration(milliseconds: 100));
    }
    currentIndex % cardCount != 1
        ? controller.animateToPage(
            currentIndex <= (itemCount - 1) / 2
                ? currentIndex + 1
                : currentIndex - 1,
            curve: Curves.linear,
            duration: const Duration(milliseconds: 200),
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
    controller.dispose();
    controller = PageController(initialPage: currentIndex);
    if (save) {
      await _save(isVisible);
    }
  }

  _save(bool isVisible) async {
    await userPrefs.setBool(PrefKeys.flowVisible, isVisible);
  }

  toggleVisibility() async {
    await updateVisibility(!visible);
  }
}
