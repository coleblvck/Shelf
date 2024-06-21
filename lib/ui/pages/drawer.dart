import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/channels/app_scout/app_detail.dart';
import 'package:shelf/state/state_util.dart';
import 'package:shelf/ui/pages/blinds.dart';
import 'package:shelf/ui/pages/boxes.dart';
import 'package:shelf/ui/pages/woven.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/loading_widget.dart';

class ShelfDrawer extends StatelessWidget {
  const ShelfDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: shelfState.search.stream.stream,
        builder: (context, searchStreamData) {
          final String term =
              searchStreamData.data ?? shelfState.search.controller.text;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  elevation: ShelfTheme.of(context).uiParameters.cardElevation,
                  color: ShelfTheme.of(context)
                      .colors
                      .primary
                      .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          RemixIcon.search,
                          size: 30,
                          color: ShelfTheme.of(context).colors.onPrimary,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: shelfState.search.controller,
                          onChanged: (term) => shelfState.search.search(),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          style: TextStyle(
                            color: ShelfTheme.of(context).colors.onPrimary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      term != ""
                          ? GestureDetector(
                              onTap: () async {
                                shelfState.search.launchBrowserSearch();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  RemixIcon.firefox,
                                  size: 30,
                                  color:
                                      ShelfTheme.of(context).colors.onPrimary,
                                ),
                              ),
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          shelfState.search.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            RemixIcon.close_circle,
                            size: 30,
                            color: ShelfTheme.of(context).colors.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<AppDetail>>(
                  stream: shelfState.apps.stream.stream,
                  builder: (context, snapshot) {
                    final List<AppDetail> searchResults = [];
                    final List<AppDetail> appsToDisplay =
                        snapshot.data ?? shelfState.apps.list;
                    for (AppDetail app in appsToDisplay) {
                      if (app.name.toLowerCase().contains(term.toLowerCase())) {
                        searchResults.add(app);
                      }
                    }
                    if (appsToDisplay.isNotEmpty) {
                      return DrawerBuilder(apps: searchResults);
                    }

                    return const LoadingWidget();
                  },
                ),
              ),
            ],
          );
        });
  }
}

class DrawerBuilder extends StatelessWidget {
  const DrawerBuilder({
    super.key,
    required this.apps,
  });

  final List<AppDetail> apps;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: shelfState.drawer.layoutStream.stream,
      builder: (context, snapshot) {
        final String layout = snapshot.data ?? shelfState.drawer.layout;
        switch (layout) {
          case "Boxes":
            return Boxes(allApps: apps);
          case "Blinds":
            return Blinds(allApps: apps);
          case "Woven":
            return WovenGrid(allApps: apps);
          default:
            return Boxes(allApps: apps);
        }
      },
    );
  }
}
