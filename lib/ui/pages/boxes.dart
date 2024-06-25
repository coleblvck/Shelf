import 'package:flutter/material.dart';
import 'package:shelf/channels/app_scout/app_detail.dart';
import 'package:shelf/ui/theming.dart';

import 'grid_item.dart';

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
              physics: const ClampingScrollPhysics(),
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
