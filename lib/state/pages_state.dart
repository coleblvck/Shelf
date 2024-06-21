import 'dart:async';

import 'package:flutter/material.dart';

class PagesState {
  PageController controller = PageController(initialPage: 1);

  int index = 1;

  StreamController<int> indexStream = StreamController.broadcast();

  togglePages() {
    controller.page == 1
        ? controller.animateToPage(
            0,
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
          )
        : controller.animateToPage(
            1,
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
          );
  }
}
