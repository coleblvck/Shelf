import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/utilities/dialogs/drawer_layout.dart';

import '../../channels/app_scout/app_detail.dart';
import '../../channels/app_scout/app_scout.dart';
import '../../custom_function.dart';
import '../../state/state_util.dart';
import '../../utilities/clock.dart';
import '../theming.dart';

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
                  shelfState.flow.goToQuickNote();
                },
                child: Icon(
                  RemixIcon.pen_nib,
                  color: ShelfTheme.of(context).colors.onPrimary,
                  size: 30,
                ),
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
                      snapshot.data ?? shelfState.pages.currentIndex;
                  return GestureDetector(
                    onTap: () {
                      shelfState.pages.togglePages();
                    },
                    onLongPress: () {
                      drawerLayoutDialog(context);
                    },
                    child: appDrawerIndex % 2 != 1
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
