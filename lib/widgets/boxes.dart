import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';


class Boxes extends StatelessWidget {
  const Boxes({
    super.key,
    required this.allApps,
  });

  final List<AppInfo> allApps;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      physics: const BouncingScrollPhysics(),
      itemCount: allApps.length,
      itemBuilder: (context, index) {
        return GridItem(appInfo: allApps[index]);
      },
    );
  }
}


class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.appInfo
  });
  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: (){InstalledApps.startApp(appInfo.packageName);},
      child: Card(
        elevation: 5,
        color: Colors.black.withAlpha(450),
        child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Image.memory(appInfo.icon!)
                ),
                Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(appInfo.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.amber),
                      ),
                    )
                ),
              ],
            )
        ),

      ),
    );
  }
}