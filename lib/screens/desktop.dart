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
import 'package:timer_builder/timer_builder.dart';

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
          },
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
                      StreamBuilder<bool>(
                        stream: firstBoxVisibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible =
                              snapshot.data ?? firstBoxVisible;
                          return isVisible ? desktopFirstBox() : Container();
                        },
                      ),
                      desktopSecondBox(),
                      StreamBuilder<bool>(
                        stream: dashboardVisibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible =
                              snapshot.data ?? dashboardVisible;
                          return isVisible ? const Dashboard() : Container();
                        },
                      ),
                    ],
                  )
                : Row(
                    children: [
                      StreamBuilder<bool>(
                        stream: firstBoxVisibilityStream.stream,
                        builder: (context, snapshot) {
                          final bool isVisible =
                              snapshot.data ?? firstBoxVisible;
                          return isVisible ? desktopFirstBox() : Container();
                        },
                      ),
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
              children: const [
                AppListBuilder(),
                HomeWidget(),
                SearchPage(),
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
                    children: const [
                      AppListBuilder(),
                      HomeWidget(),
                      SearchPage(),
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

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const GestureBox();
  }
}

class SettingsBox extends StatelessWidget {
  const SettingsBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: ShelfTheme.of(context).colors.primary.withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
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
        if (details.primaryVelocity! > 200 && dashboardVisible) {
          updateDashboardVisibility(false);
        }
        if (details.primaryVelocity! < -200 && !dashboardVisible) {
          updateDashboardVisibility(true);
        }
      },
      child: Container(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({
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
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TimeWidget(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleFirstBoxVisibility();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: StreamBuilder<bool>(
                      stream: firstBoxVisibilityStream.stream,
                      builder: (context, snapshot) {
                        final bool isVisible = snapshot.data ?? firstBoxVisible;
                        return isVisible
                            ? Icon(
                                RemixIcon.eye_2,
                                color: ShelfTheme.of(context).colors.onPrimary,
                                size: 30,
                              )
                            : Icon(
                                RemixIcon.eye_close,
                                color: ShelfTheme.of(context).colors.onPrimary,
                                size: 30,
                              );
                      }),
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
                  final int appDrawerIndex = snapshot.data ?? secondBoxIndex;
                  return GestureDetector(
                    onTap: () {
                      toggleMenu();
                    },
                    onLongPress: () {
                      refreshShelf();
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        expandNotificationBar();
      },
      child: TimerBuilder.periodic(
        const Duration(seconds: 1),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              getCurrentTime(),
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: ShelfTheme.of(context).colors.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: ShelfTheme.of(context).colors.onPrimary,
              ),
            ),
          );
        },
      ),
    );
  }
}

PageController secondBoxController = PageController(initialPage: 1);

int secondBoxIndex = 1;

StreamController<int> secondBoxIndexStream = StreamController.broadcast();
