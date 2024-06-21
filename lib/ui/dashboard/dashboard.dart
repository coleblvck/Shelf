import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/state/drawer_state.dart';

import '../../channels/app_scout/app_detail.dart';
import '../../channels/app_scout/app_scout.dart';
import '../../global_variables.dart';
import '../../state/state_util.dart';
import '../../utilities/clock.dart';
import '../theming.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  showLayoutSetDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ShelfTheme.of(context).colors.tertiary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                RemixIcon.dashboard,
                color: ShelfTheme.of(context).colors.onTertiary,
                size: 50,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Drawer Layout",
                style: TextStyle(
                    color: ShelfTheme.of(context).colors.onTertiary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (shelfState.drawer.layout != DrawerLayout.woven) {
                    shelfState.drawer.updateLayout(DrawerLayout.woven);
                    Navigator.of(context).pop();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ShelfTheme.of(context).colors.tertiary,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DrawerLayout.woven,
                      style: TextStyle(
                          fontSize: 20,
                          color: ShelfTheme.of(context).colors.onTertiary),
                    ),
                    shelfState.drawer.layout == DrawerLayout.woven
                        ? Checkbox(
                            value: true,
                            onChanged: null,
                            checkColor: ShelfTheme.of(context).colors.onTertiary,
                            fillColor: WidgetStatePropertyAll(
                              ShelfTheme.of(context).colors.tertiary,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              ElevatedButton(
                onPressed: () {
                  if (shelfState.drawer.layout != DrawerLayout.boxes) {
                    shelfState.drawer.updateLayout(DrawerLayout.boxes);
                    Navigator.of(context).pop();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ShelfTheme.of(context).colors.tertiary,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DrawerLayout.boxes,
                      style: TextStyle(
                          fontSize: 20,
                          color: ShelfTheme.of(context).colors.onTertiary),
                    ),
                    shelfState.drawer.layout == DrawerLayout.boxes
                        ? Checkbox(
                      value: true,
                      onChanged: null,
                      checkColor: ShelfTheme.of(context).colors.onTertiary,
                      fillColor: WidgetStatePropertyAll(
                        ShelfTheme.of(context).colors.tertiary,
                      ),
                    )
                        : Container()
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              ElevatedButton(
                onPressed: () {
                  if (shelfState.drawer.layout != DrawerLayout.blinds) {
                    shelfState.drawer.updateLayout(DrawerLayout.blinds);
                    Navigator.of(context).pop();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ShelfTheme.of(context).colors.tertiary,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DrawerLayout.blinds,
                      style: TextStyle(
                          fontSize: 20,
                          color: ShelfTheme.of(context).colors.onTertiary),
                    ),
                    shelfState.drawer.layout == DrawerLayout.blinds
                        ? Checkbox(
                      value: true,
                      onChanged: null,
                      checkColor: ShelfTheme.of(context).colors.onTertiary,
                      fillColor: WidgetStatePropertyAll(
                        ShelfTheme.of(context).colors.tertiary,
                      ),
                    )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
              StreamBuilder<List<bool>>(
                stream: shelfState.isShelfRefreshingStream.stream,
                builder: (context, snapshot) {
                  final List<bool> isRefreshing =
                      snapshot.data ?? shelfState.isShelfRefreshing;
                  return GestureDetector(
                    onTap: () {
                      if (!isRefreshing[0]) {
                        shelfState.refreshShelf();
                      }
                      if (!isRefreshing[0]) {
                        shelfState.refreshShelf();
                      }
                    },
                    onLongPress: () {
                      if (!isRefreshing[0]) {
                        shelfState.refreshShelf(forceUpdate: true);
                      }
                    },
                    child: Icon(
                      RemixIcon.restart,
                      color: isRefreshing[0] && isRefreshing[1]
                          ? Colors.red
                          : isRefreshing[0] && !isRefreshing[1]
                              ? Colors.amber
                              : ShelfTheme.of(context).colors.onPrimary,
                      size: 30,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  shelfState.flow.toggleVisibility();
                },
                child: StreamBuilder<bool>(
                  stream: shelfState.flow.visibilityStream.stream,
                  builder: (context, snapshot) {
                    final bool isVisible =
                        snapshot.data ?? shelfState.flow.visible;
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
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              StreamBuilder<List<AppDetail>>(
                stream: shelfState.apps.stream.stream,
                builder: (context, snapshot) {
                  final List<AppDetail> apps =
                      snapshot.data ?? shelfState.apps.list;
                  return apps
                          .map((app) => app.packageName)
                          .contains(leadingWidgetApp)
                      ? Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                AppScout.launchApp(leadingWidgetApp);
                              },
                              child: widgets(context)[leadingWidget],
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        )
                      : Container();
                },
              ),
              StreamBuilder<int>(
                stream: shelfState.pages.indexStream.stream,
                builder: (context, snapshot) {
                  final int appDrawerIndex =
                      snapshot.data ?? shelfState.pages.index;
                  return GestureDetector(
                    onTap: () {
                      shelfState.pages.togglePages();
                    },
                    onLongPress: () {
                      showLayoutSetDialog(context);
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
