import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';

import '../../state/drawer_state.dart';
import '../../state/state_util.dart';
import '../../ui/theming.dart';

drawerLayoutDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ShelfTheme.of(context).colors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              RemixIcon.dashboard,
              color: ShelfTheme.of(context).colors.onSecondary,
              size: 50,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Drawer Layout",
              style: TextStyle(
                  color: ShelfTheme.of(context).colors.onSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                if (shelfState.drawer.layout != DrawerLayout.woven) {
                  shelfState.drawer.updateLayout(DrawerLayout.woven);
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  ShelfTheme.of(context).colors.secondary,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DrawerLayout.woven,
                    style: TextStyle(
                        fontSize: 20,
                        color: ShelfTheme.of(context).colors.onSecondary),
                  ),
                  shelfState.drawer.layout == DrawerLayout.woven
                      ? Checkbox(
                          value: true,
                          onChanged: null,
                          checkColor: ShelfTheme.of(context).colors.onSecondary,
                          fillColor: WidgetStatePropertyAll(
                            ShelfTheme.of(context).colors.secondary,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                if (shelfState.drawer.layout != DrawerLayout.boxes) {
                  shelfState.drawer.updateLayout(DrawerLayout.boxes);
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  ShelfTheme.of(context).colors.secondary,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DrawerLayout.boxes,
                    style: TextStyle(
                        fontSize: 20,
                        color: ShelfTheme.of(context).colors.onSecondary),
                  ),
                  shelfState.drawer.layout == DrawerLayout.boxes
                      ? Checkbox(
                          value: true,
                          onChanged: null,
                          checkColor: ShelfTheme.of(context).colors.onSecondary,
                          fillColor: WidgetStatePropertyAll(
                            ShelfTheme.of(context).colors.secondary,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                if (shelfState.drawer.layout != DrawerLayout.blinds) {
                  shelfState.drawer.updateLayout(DrawerLayout.blinds);
                  Navigator.of(context).pop();
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  ShelfTheme.of(context).colors.secondary,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DrawerLayout.blinds,
                    style: TextStyle(
                        fontSize: 20,
                        color: ShelfTheme.of(context).colors.onSecondary),
                  ),
                  shelfState.drawer.layout == DrawerLayout.blinds
                      ? Checkbox(
                          value: true,
                          onChanged: null,
                          checkColor: ShelfTheme.of(context).colors.onSecondary,
                          fillColor: WidgetStatePropertyAll(
                            ShelfTheme.of(context).colors.secondary,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
