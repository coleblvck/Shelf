import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/shelf_utils.dart';
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
                SearchPage(),
                GestureBox(),
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
                      SearchPage(),
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
          toggleFirstBoxVisibility();
        }
      },
      onDoubleTap: () {
        toggleDashboardVisibility();
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
              StreamBuilder<bool>(
                  stream: isShelfRefreshingStream.stream,
                  builder: (context, snapshot) {
                    final bool isRefreshing =
                        snapshot.data ?? isShelfRefreshing;
                    return GestureDetector(
                      onTap: () {
                        if (!isRefreshing) {
                          refreshShelf();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          RemixIcon.restart,
                          color: isRefreshing
                              ? Colors.red
                              : ShelfTheme.of(context).colors.onPrimary,
                          size: 30,
                        ),
                      ),
                    );
                  }),
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
                  actions(param: leadingWidgetApp)[leadingWidgetAction];
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: widgets(
                      context)[leadingWidget],
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
                    onLongPress: () {},
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
      onLongPress: () {
        toggleSystemUIMode();
      },
      onTap: () {
        expandNotificationBar();
      },
      child: Card(
        elevation: ShelfTheme.of(context).uiParameters.cardElevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: ShelfTheme.of(context)
            .colors
            .secondary
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (context) {
              return Text(
                getCurrentTime(),
                style: TextStyle(
                  decoration: TextDecoration.none,
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: ShelfTheme.of(context).colors.onSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: ShelfTheme.of(context).colors.onSecondary,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

PageController secondBoxController = PageController(initialPage: 1);

int secondBoxIndex = 1;

StreamController<int> secondBoxIndexStream = StreamController.broadcast();
