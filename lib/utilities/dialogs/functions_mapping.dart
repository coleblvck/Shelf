import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/channels/app_scout/app_detail.dart';
import 'package:shelf/custom_functions.dart';
import 'package:shelf/state/state_util.dart';
import 'package:shelf/ui/theming.dart';

functionMappingDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ShelfTheme.of(context).colors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(4.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              RemixIcon.sparkling,
              color: ShelfTheme.of(context).colors.onSecondary,
              size: 50,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Custom Mapping",
              style: TextStyle(
                  color: ShelfTheme.of(context).colors.onSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: StatefulBuilder(builder: (context, set) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Available Icons",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ShelfTheme.of(context).colors.onSecondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (String key in shelfState.functions.widgetKeys)
                        GestureDetector(
                          onTap: () {
                            shelfState.functions
                                .updateCustomBehavior(widget: key);
                            set(() {});
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: shelfState.functions.currentWidget == key
                                ? ShelfTheme.of(context).colors.secondary
                                : ShelfTheme.of(context).colors.primary,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: shelfState.functions.widgets[key],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "Available Functions",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ShelfTheme.of(context).colors.onSecondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  color: ShelfTheme.of(context).colors.tertiary,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                shelfState.functions.currentBehaviour !=
                                        BehaviourKeys.none
                                    ? ShelfTheme.of(context).colors.primary
                                    : ShelfTheme.of(context).colors.secondary,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              shelfState.functions.updateCustomBehavior(
                                  behaviour: BehaviourKeys.none);
                              set(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  RemixIcon.close_circle,
                                  color: shelfState
                                              .functions.currentBehaviour !=
                                          BehaviourKeys.none
                                      ? ShelfTheme.of(context).colors.onPrimary
                                      : ShelfTheme.of(context)
                                          .colors
                                          .onSecondary,
                                  size: 28,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Do Nothing",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        shelfState.functions.currentBehaviour !=
                                                BehaviourKeys.none
                                            ? ShelfTheme.of(context)
                                                .colors
                                                .onPrimary
                                            : ShelfTheme.of(context)
                                                .colors
                                                .onSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: ShelfTheme.of(context).colors.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      RemixIcon.rocket,
                                      color: ShelfTheme.of(context)
                                          .colors
                                          .onPrimary,
                                      size: 28,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Launch:",
                                      style: TextStyle(
                                        color: ShelfTheme.of(context)
                                            .colors
                                            .onPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (AppDetail app
                                          in shelfState.apps.list)
                                        SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: GestureDetector(
                                            onTap: () {
                                              shelfState.functions
                                                  .updateCustomBehavior(
                                                package: app.packageName,
                                                behaviour: BehaviourKeys.launch,
                                              );
                                              set(() {});
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              color: app.packageName ==
                                                          shelfState.functions
                                                              .currentPackage &&
                                                      shelfState.functions
                                                              .currentBehaviour ==
                                                          BehaviourKeys.launch
                                                  ? ShelfTheme.of(context)
                                                      .colors
                                                      .secondary
                                                  : ShelfTheme.of(context)
                                                      .colors
                                                      .surface
                                                      .withAlpha(
                                                          ShelfTheme.of(context)
                                                              .uiParameters
                                                              .cardAlpha),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Image.memory(
                                                            app.icon!)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0),
                                                      child: Text(
                                                        app.name,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: app.packageName ==
                                                                      shelfState
                                                                          .functions
                                                                          .currentPackage &&
                                                                  shelfState
                                                                          .functions
                                                                          .currentBehaviour ==
                                                                      BehaviourKeys
                                                                          .launch
                                                              ? ShelfTheme.of(
                                                                      context)
                                                                  .colors
                                                                  .onSecondary
                                                              : ShelfTheme.of(
                                                                      context)
                                                                  .colors
                                                                  .primary,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        ShelfTheme.of(context).colors.primary,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          RemixIcon.check,
                          color: ShelfTheme.of(context).colors.onPrimary,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 20,
                            color: ShelfTheme.of(context).colors.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    },
  );
}
