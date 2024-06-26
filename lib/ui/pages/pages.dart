import 'package:flutter/material.dart';
import 'package:shelf/channels/shelf/shelf.dart';
import 'package:shelf/state/pages_state.dart';
import 'package:shelf/state/state_util.dart';
import 'package:shelf/ui/flow/flow.dart';

class ShelfPages extends StatelessWidget {
  const ShelfPages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? PageList()
          : Row(
              children: [
                StreamBuilder<bool>(
                  stream: shelfState.flow.visibilityStream.stream,
                  builder: (context, snapshot) {
                    final bool isVisible =
                        snapshot.data ?? shelfState.flow.visible;
                    return isVisible ? ShelfFlow() : Container();
                  },
                ),
                Expanded(
                  child: PageList(),
                ),
              ],
            ),
    );
  }
}

class PageList extends StatelessWidget {
  PageList({
    super.key,
  });

  final PagesState state = shelfState.pages;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const ClampingScrollPhysics(),
      pageSnapping: false,
      controller: state.controller,
      onPageChanged: (index) {
        state.onPageChanged(index);
      },
      itemCount: state.itemCount,
      itemBuilder: (context, index) {
        return state.pages[index % state.pageCount];
      },
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
      onLongPress: () {
        shelfState.parallax.toggleStatus();
      },
      child: Container(),
    );
  }
}
