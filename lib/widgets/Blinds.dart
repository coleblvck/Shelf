import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
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
  BlindItem({super.key, required this.appInfo});
  final AppInfo appInfo;
  final FlipCardController thisAppFlipController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      controller: thisAppFlipController,
      side: CardSide.FRONT,
      flipOnTouch: false,
      direction: FlipDirection.VERTICAL,
      front: BlindFront(
          appInfo: appInfo, thisAppFlipController: thisAppFlipController),
      back: BlindBack(
          thisAppFlipController: thisAppFlipController, appInfo: appInfo),
    );
  }
}

class BlindBack extends StatelessWidget {
  const BlindBack({
    super.key,
    required this.thisAppFlipController,
    required this.appInfo,
  });

  final FlipCardController thisAppFlipController;
  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onLongPress: thisAppFlipController.toggleCard,
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
                GestureDetector(
                  onTap: () {
                    thisAppFlipController.toggleCard();
                  },
                  child: Image.memory(appInfo.icon!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlindFront extends StatelessWidget {
  const BlindFront({
    super.key,
    required this.appInfo,
    required this.thisAppFlipController,
  });

  final AppInfo appInfo;
  final FlipCardController thisAppFlipController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          InstalledApps.startApp(appInfo.packageName);
        },
        onLongPress: thisAppFlipController.toggleCard,
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
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            thisAppFlipController.toggleCard();
                          },
                          child: Image.memory(appInfo.icon!))),
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
    );
  }
}
