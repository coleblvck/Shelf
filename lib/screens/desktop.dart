import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/shelf_utils.dart';
import 'package:shelf/widgets/app_list.dart';
import 'package:shelf/widgets/fab.dart';
import 'package:shelf/widgets/search.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => {
        if (secondBoxIndex != 1)
          {
            secondBoxController.animateToPage(
              1,
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 300),
            ),
          }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    children: [
                      desktopFirstBox(),
                      desktopSecondBox(),
                      const UtilCard(),
                    ],
                  )
                : Row(
                    children: [
                      desktopFirstBox(),
                      desktopSecondBox(landscapeOT: true),
                    ],
                  ),
          ),
        ),
        floatingActionButton: fabEnabled ? fab(context) : null,
      ),
    );
  }

  Expanded desktopFirstBox() {
    return Expanded(
      flex: 2,
      child: desktopBox1Child,
    );
  }

  Expanded desktopSecondBox({bool landscapeOT = false}) {
    return Expanded(
      flex: 4,
      child: !landscapeOT
          ? PageView(
              controller: secondBoxController,
              onPageChanged: (index) {
                secondBoxIndexStream.add(index);
                secondBoxIndex = index;
              },
              children: [
                const AppListBuilder(),
                Container(),
                const SearchPage(),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: secondBoxController,
                    onPageChanged: (index) {
                      secondBoxIndexStream.add(index);
                      secondBoxIndex = index;
                    },
                    children: [
                      const AppListBuilder(),
                      Container(),
                    ],
                  ),
                ),
                const UtilCard(),
              ],
            ),
    );
  }
}

class UtilCard extends StatelessWidget {
  const UtilCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
          elevation: ShelfTheme.of(context).uiParameters.cardElevation,
          color: ShelfTheme.of(context)
              .colors
              .primary
              .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          refreshShelf();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            RemixIcon.restart_outline,
                            color: ShelfTheme.of(context).colors.onPrimary,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    launchApp(fabApp);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: widgetsWithActions(
                        context)[currentActionWidgetAction]!["widget"],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    secondBoxController.animateToPage(
                      2,
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      RemixIcon.search,
                      color: ShelfTheme.of(context).colors.onPrimary,
                      size: 30,
                    ),
                  ),
                ),
                StreamBuilder<int>(
                    stream: secondBoxIndexStream.stream,
                    builder: (context, snapshot) {
                      final int appDrawerIndex =
                          snapshot.data ?? secondBoxIndex;
                      return GestureDetector(
                        onTap: () {
                          toggleMenu();
                        },
                        child: appDrawerIndex != 1
                            ? Icon(
                                RemixIcon.dashboard,
                                color: ShelfTheme.of(context).colors.onPrimary,
                                size: 30,
                              )
                            : Icon(
                                RemixIcon.apps_2,
                                color: ShelfTheme.of(context).colors.onPrimary,
                                size: 30,
                              ),
                      );
                    }),
              ],
            ),
          )),
    );
  }
}

PageController secondBoxController = PageController(initialPage: 1);

int secondBoxIndex = 1;

StreamController<int> secondBoxIndexStream = StreamController.broadcast();
