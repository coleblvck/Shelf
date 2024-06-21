import 'package:flutter/material.dart';

import '../../channels/app_scout/app_detail.dart';
import 'blind_item.dart';

class Blinds extends StatelessWidget {
  const Blinds({
    super.key,
    required this.allApps,
  });

  final List<AppDetail> allApps;

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
