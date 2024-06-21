
import 'package:flutter/material.dart';

import '../../channels/app_scout/app_detail.dart';
import '../../channels/app_scout/app_scout.dart';
import '../theming.dart';

class BlindItem extends StatelessWidget {
  const BlindItem({super.key, required this.appInfo});
  final AppDetail appInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          AppScout.launchApp(appInfo.packageName);
        },
        onLongPress: () {
          AppScout.openAppSettings(appInfo.packageName);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}