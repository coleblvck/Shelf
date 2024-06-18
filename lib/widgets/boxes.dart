import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/ui/theming.dart';

class Boxes extends StatelessWidget {
  const Boxes({
    super.key,
    required this.allApps,
  });

  final List<AppInfo> allApps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: ShelfTheme.of(context)
            .colors
            .surface
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            physics: const BouncingScrollPhysics(),
            itemCount: allApps.length,
            itemBuilder: (context, index) {
              return GridItem(appInfo: allApps[index]);
            },
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.appInfo});
  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchApp(appInfo.packageName);
      },
      onLongPress: () {
        openAppSettings(appInfo.packageName);
      },
      child: Card(
        elevation: 5,
        color: ShelfTheme.of(context)
            .colors
            .surface
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 1, child: Image.memory(appInfo.icon!)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    appInfo.name,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: ShelfTheme.of(context).colors.primary),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
