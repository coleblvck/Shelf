import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
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
  BlindItem({super.key, required this.appInfo});
  final AppInfo appInfo;
  final FlipCardController thisAppFlipController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: thisAppFlipController,
      rotateSide: RotateSide.bottom,
      animationDuration: const Duration(milliseconds: 400),
      onTapFlipping: false,
      frontWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            InstalledApps.startApp(appInfo.packageName);
          },
          onLongPress: thisAppFlipController.flipcard,
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
      ),
      backWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onLongPress: thisAppFlipController.flipcard,
          child: Card(
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
        ),
      ),
    );
  }
}
