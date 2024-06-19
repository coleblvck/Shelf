import 'package:flutter/material.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/app_scout/app_detail.dart';
import 'package:shelf/utilities/app_scout/app_scout.dart';

class Boxes extends StatelessWidget {
  const Boxes({
    super.key,
    required this.allApps,
  });

  final List<AppDetail> allApps;

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
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemCount: allApps.length,
                  itemBuilder: (context, index) {
                    return GridItem(appInfo: allApps[index]);
                  },
                ),
              ]),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.appInfo});
  final AppDetail appInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppScout.launchApp(appInfo.packageName);
      },
      onLongPress: () {
        AppScout.openAppSettings(appInfo.packageName);
      },
      child: Card(
        elevation: 5,
        color: ShelfTheme.of(context)
            .colors
            .surface
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: Padding(
          padding: const EdgeInsets.all(4),
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
                  style: TextStyle(
                    color: ShelfTheme.of(context).colors.primary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
