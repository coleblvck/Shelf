import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/utilities/app_scout/app_detail.dart';
import 'package:shelf/utilities/app_scout/app_scout.dart';

import '../flow/flow.dart';
import '../global_variables.dart';
import '../pages/pages.dart';
import '../ui/theming.dart';
import '../utilities/clock.dart';
import '../utilities/shelf_utils.dart';

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
                  toggleFlowVisibility();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: StreamBuilder<bool>(
                      stream: flowVisibilityStream.stream,
                      builder: (context, snapshot) {
                        final bool isVisible = snapshot.data ?? flowVisible;
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
              StreamBuilder<List<AppDetail>>(
                  stream: allAppsListStream.stream,
                  builder: (context, snapshot) {
                    final List<AppDetail> apps = snapshot.data ?? allAppsList;
                    return apps
                            .map((app) => app.packageName)
                            .contains(leadingWidgetApp)
                        ? GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              AppScout.launchApp(leadingWidgetApp);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: widgets(context)[leadingWidget],
                            ),
                          )
                        : Container();
                  }),
              StreamBuilder<int>(
                stream: pagesIndexStream.stream,
                builder: (context, snapshot) {
                  final int appDrawerIndex = snapshot.data ?? pagesIndex;
                  return GestureDetector(
                    onTap: () {
                      togglePagesGestureBoxDrawer();
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
