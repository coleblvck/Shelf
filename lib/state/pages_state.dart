import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shelf/ui/pages/drawer.dart';
import 'package:shelf/ui/pages/pages.dart';

class PagesState {
  int initialPage = 5;
  int itemCount = 9;
  late int pageCount;
  late int currentIndex;
  late PageController controller;
  StreamController<int> indexStream = StreamController.broadcast();
  List<Widget> pages = const [
    ShelfDrawer(),
    GestureBox(),
  ];

  init() {
    currentIndex = initialPage;
    controller = PageController(initialPage: initialPage);
    pageCount = pages.length;
  }

  onPageChanged(int index) {
    currentIndex = index;
    indexStream.add(index);
  }

  togglePages() {
    controller.animateToPage(
      currentIndex <= (itemCount - 1) / 2 ? currentIndex + 1 : currentIndex - 1,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 200),
    );
  }
}
