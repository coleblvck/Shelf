import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelf/pages/drawer.dart';

import '../dashboard/dashboard.dart';
import '../flow/flow.dart';
import '../utilities/shelf_utils.dart';

PageController pagesController = PageController(initialPage: 1);

int pagesIndex = 1;

StreamController<int> pagesIndexStream = StreamController.broadcast();

togglePagesGestureBoxDrawer() {
  pagesController.page == 1
      ? pagesController.animateToPage(
          0,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 300),
        )
      : pagesController.animateToPage(
          1,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 300),
        );
}

class ShelfPages extends StatelessWidget {
  const ShelfPages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? PageView(
              controller: pagesController,
              onPageChanged: (index) {
                pagesIndexStream.add(index);
                pagesIndex = index;
              },
              children: const [
                ShelfDrawer(),
                GestureBox(),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: pagesController,
                    onPageChanged: (index) {
                      pagesIndexStream.add(index);
                      pagesIndex = index;
                    },
                    children: const [
                      ShelfDrawer(),
                      GestureBox(),
                    ],
                  ),
                ),
                StreamBuilder<bool>(
                  stream: dashboardVisibilityStream.stream,
                  builder: (context, snapshot) {
                    final bool isVisible = snapshot.data ?? dashboardVisible;
                    return isVisible ? const Dashboard() : Container();
                  },
                ),
              ],
            ),
    );
  }
}

class GestureBox extends StatelessWidget {
  const GestureBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 200) {
          expandNotificationBar();
        }
        if (details.primaryVelocity! < -200 &&
            MediaQuery.of(context).orientation == Orientation.portrait) {
          toggleFlowVisibility();
        }
      },
      onDoubleTap: () {
        toggleDashboardVisibility();
      },
      child: Container(),
    );
  }
}
