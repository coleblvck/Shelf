import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../channels/app_scout/app_detail.dart';
import '../theming.dart';
import 'grid_item.dart';

class WovenGrid extends StatelessWidget {
  const WovenGrid({
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
                  gridDelegate: SliverWovenGridDelegate.count(
                    crossAxisCount: 5,
                    pattern: const [
                      WovenGridTile(1),
                      WovenGridTile(
                        5 / 7,
                        crossAxisRatio: 0.9,
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                    ],
                  ),
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
