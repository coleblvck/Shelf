
import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';

import '../../ui/theming.dart';

showHintDialog(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                RemixIcon.lightbulb,
                color: ShelfTheme.of(context).colors.onTertiary,
                size: 50,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Hints",
                style: TextStyle(
                    color: ShelfTheme.of(context).colors.onTertiary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: ShelfTheme.of(context).colors.tertiary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "- Long press on an app to open its settings page.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "- Long press on header to edit header text. Swipe left on header or tap",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(
                          RemixIcon.pen_nib,
                          size: 24,
                          color: ShelfTheme.of(context).colors.onTertiary,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      TextSpan(
                        text:
                        "to take a quick note.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "- Tap",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(
                          RemixIcon.eye_2,
                          size: 24,
                          color: ShelfTheme.of(context).colors.onTertiary,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      TextSpan(
                        text: "or swipe up on empty space to show/hide header and note cards.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "- Tap",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(
                          RemixIcon.firefox,
                          size: 24,
                          color: ShelfTheme.of(context).colors.onTertiary,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      TextSpan(
                        text: "during app drawer search for a quick website visit or google search.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "- Tap on clock or swipe down on empty space to expand status bar.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "- Long press on clock to show/hide system UI.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "- Long press",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(
                          RemixIcon.apps_2,
                          size: 24,
                          color: ShelfTheme.of(context).colors.onTertiary,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      TextSpan(
                        text:
                        "to change drawer layout.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "- DoubleTap on empty space to show/hide bottom dashboard.",
                        style: TextStyle(
                            color: ShelfTheme.of(context).colors.onTertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}