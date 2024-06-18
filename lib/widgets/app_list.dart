import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/widgets/blinds.dart';
import 'package:shelf/widgets/boxes.dart';

class AppListBuilder extends StatelessWidget {
  const AppListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AppInfo>>(
      stream: allAppsListStream.stream,
      builder: (context, data) {
        final List<AppInfo> allApps = data.data ?? allAppsList;
        if (allApps.isNotEmpty) {
          return StreamBuilder<String>(
            stream: drawerLayoutStream.stream,
            builder: (context, snapshot) {
              final String layout = snapshot.data ?? drawerLayout;
              return layout == "Boxes"
                  ? Boxes(allApps: allApps)
                  : Blinds(allApps: allApps);
            },
          );
        }
        return const LoadingWidget();
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: ShelfTheme.of(context).colors.primary,
    ));
  }
}
