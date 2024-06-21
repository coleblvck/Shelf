
import 'package:flutter/material.dart';
import 'package:shelf/ui/pages/drawer.dart';

import '../../channels/shelf/shelf.dart';
import '../../state/pages_state.dart';
import '../../state/state_util.dart';
import '../dashboard/dashboard.dart';
import '../flow/flow.dart';


class ShelfPages extends StatelessWidget {
  ShelfPages({
    super.key,
  });

  final PagesState pagesState = shelfState.pages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? PageView(
              controller: pagesState.controller,
              onPageChanged: (index) {
                pagesState.indexStream.add(index);
                pagesState.index = index;
              },
              children: const [
                ShelfDrawer(),
                GestureBox(),
              ],
            )
          : Row(
              children: [
                StreamBuilder<bool>(
                  stream: shelfState.flow.visibilityStream.stream,
                  builder: (context, snapshot) {
                    final bool isVisible = snapshot.data ?? shelfState.flow.visible;
                    return isVisible ? const ShelfFlow() : Container();
                  },
                ),
                Expanded(
                  child: PageView(
                    controller: pagesState.controller,
                    onPageChanged: (index) {
                      pagesState.indexStream.add(index);
                      pagesState.index = index;
                    },
                    children: const [
                      ShelfDrawer(),
                      GestureBox(),
                    ],
                  ),
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
          ShelfChannel.expandNotificationBar();
        }
        if (details.primaryVelocity! < -200 &&
            MediaQuery.of(context).orientation == Orientation.portrait) {
          shelfState.flow.toggleVisibility();
        }
      },
      onDoubleTap: () {
        shelfState.dashboard.toggleVisibility();
      },
      child: Container(),
    );
  }
}
