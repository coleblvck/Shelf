import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/pages/blinds.dart';
import 'package:shelf/pages/boxes.dart';
import 'package:shelf/utilities/app_scout/app_detail.dart';

import '../utilities/loading_widget.dart';


String drawerLayout = "Boxes";
StreamController<String> drawerLayoutStream = StreamController.broadcast();

String searchTerm = "";
final TextEditingController searchController = TextEditingController();
final StreamController searchStreamController = StreamController.broadcast();
search() {
  searchStreamController.add(searchController.text);
}

class ShelfDrawer extends StatelessWidget {
  const ShelfDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              final String term = searchStreamData.data ?? searchTerm;
              return StreamBuilder<List<AppDetail>>(
                stream: allAppsListStream.stream,
                builder: (context, snapshot) {
                  final List<AppDetail> searchResults = [];
                  final List<AppDetail> appsToDisplay =
                      snapshot.data ?? allAppsList;
                  for (AppDetail app in appsToDisplay) {
                    if (app.name
                        .toLowerCase()
                        .contains(term.toLowerCase())) {
                      searchResults.add(app);
                    }
                  }
                  if (appsToDisplay.isNotEmpty) {
                    return DrawerBuilder(apps: searchResults);
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

class DrawerBuilder extends StatelessWidget {
  const DrawerBuilder({
    super.key,
    required this.apps,
  });

  final List<AppDetail> apps;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: drawerLayoutStream.stream,
      builder: (context, snapshot) {
        final String layout = snapshot.data ?? drawerLayout;
        return layout == "Boxes" ? Boxes(allApps: apps) : Blinds(allApps: apps);
      },
    );
  }
}