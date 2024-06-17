import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/ui/theming.dart';

class Blinds extends StatelessWidget {
  const Blinds({
    super.key,
    required this.allApps,
  });

  final List<AppInfo> allApps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: allApps.length,
      itemExtent: 60,
      itemBuilder: (context, index) {
        return BlindItem(appInfo: allApps[index]);
      },
    );
  }
}

class BlindItem extends StatelessWidget {
  const BlindItem({super.key, required this.appInfo});
  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        GestureDetector(
          onTap: () {
            InstalledApps.startApp(appInfo.packageName);
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
                            color: ShelfTheme.of(context).colors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Card(
          elevation: ShelfTheme.of(context).uiParameters.cardElevation,
          color: ShelfTheme.of(context)
              .colors
              .secondary
              .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    InstalledApps.openSettings(appInfo.packageName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      RemixIcon.information,
                      size: 28,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    InstalledApps.uninstallApp(appInfo.packageName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      RemixIcon.delete_bin_7,
                      size: 28,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      appInfo.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: ShelfTheme.of(context).colors.onSecondary),
                    ),
                  ),
                ),
                Image.memory(appInfo.icon!),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
