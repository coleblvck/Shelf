import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/shelf_utils.dart';
import 'package:shelf/widgets/app_list.dart';
import 'package:shelf/widgets/fab.dart';

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
            secondBoxController.jumpToPage(1),
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
                      utilCard(),
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

  Padding utilCard() {
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
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        RemixIcon.search,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchApp(fabApp);
                  },
                  child: widgetsWithActions(
                      context)[currentActionWidgetAction]!["widget"],
                ),
                GestureDetector(
                  onTap: () {
                    refreshShelf();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      RemixIcon.restart_outline,
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

  Card searchCard() {
    return Card(
        elevation: ShelfTheme.of(context).uiParameters.cardElevation,
        color: ShelfTheme.of(context)
            .colors
            .primary
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                RemixIcon.search,
                size: 30,
              ),
            ),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (term) => setState(() {
                  search(term);
                }),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: () {
                refreshShelf();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  RemixIcon.refresh_outline,
                  size: 30,
                ),
              ),
            ),
            GestureDetector(
              child: widgetsWithActions(
                  context)[currentActionWidgetAction]!["widget"],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  searchController.clear();
                  search("");
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  RemixIcon.close_circle,
                  size: 30,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  toggleMenu();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: menuShown
                    ? const Icon(
                        RemixIcon.arrow_left_up,
                        size: 30,
                      )
                    : const Icon(
                        RemixIcon.menu_4,
                        size: 30,
                      ),
              ),
            ),
          ],
        ));
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
                utilCard(),
              ],
            ),
    );
  }
}

PageController secondBoxController = PageController(initialPage: 1);

int secondBoxIndex = 1;

StreamController<int> secondBoxIndexStream = StreamController.broadcast();
