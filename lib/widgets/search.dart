import 'dart:async';

import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/shelf_utils.dart';
import 'package:shelf/widgets/app_list.dart';
import 'package:shelf/widgets/Blinds.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String term = "";
    final TextEditingController searchController = TextEditingController();
    final StreamController searchStreamController =
        StreamController.broadcast();
    search() {
      searchStreamController.add(searchController.text);
    }

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
                    controller: searchController,
                    onChanged: (term) => search(),
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: TextStyle(
                      color: ShelfTheme.of(context).colors.onPrimary,
                      fontSize: 20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    searchController.text = "";
                    searchStreamController.add("");
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
          child: StreamBuilder(
            stream: searchStreamController.stream,
            builder: (context, searchStreamData) {
              final String searchTerm = searchStreamData.data ?? term;
              return StreamBuilder<List<AppInfo>>(
                stream: allAppsListStream.stream,
                builder: (context, snapshot) {
                  final List<AppInfo> searchResults = [];
                  final List<AppInfo> appsToDisplay =
                      snapshot.data ?? allAppsList;
                  for (AppInfo app in appsToDisplay) {
                    if (app.name
                        .toLowerCase()
                        .contains(searchTerm.toLowerCase())) {
                      searchResults.add(app);
                    }
                  }
                  if (appsToDisplay.isNotEmpty) {
                    return SearchResultsBuilder(apps: searchResults);
                  }

                  return const LoadingWidget();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchResultsBuilder extends StatelessWidget {
  const SearchResultsBuilder({
    super.key,
    required this.apps,
  });

  final List<AppInfo> apps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: apps.length,
      itemExtent: 60,
      itemBuilder: (context, index) {
        return SearchResultAppItem(appInfo: apps[index]);
      },
    );
  }
}

class SearchResultAppItem extends StatelessWidget {
  const SearchResultAppItem({
    super.key,
    required this.appInfo,
  });

  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          InstalledApps.startApp(appInfo.packageName);
        },
        onLongPress: () {
          InstalledApps.openSettings(appInfo.packageName);
        },
        child: Card(
          elevation: ShelfTheme.of(context).uiParameters.cardElevation,
          color: ShelfTheme.of(context)
              .colors
              .surface
              .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 1, child: Image.memory(appInfo.icon!)),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      appInfo.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ShelfTheme.of(context).colors.onSurface,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    RemixIcon.information,
                    size: 30,
                    color: ShelfTheme.of(context).colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
