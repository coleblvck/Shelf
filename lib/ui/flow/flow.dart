import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/state/state_util.dart';

import '../theming.dart';

class ShelfFlow extends StatelessWidget {
  const ShelfFlow({
    super.key,
  });

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
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "- Long press on header to edit, swipe left to take a quick note.",
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
                        text: "or swipe up on empty space to show/hide top cards.",
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
                            "- Tap on clock or swipe down on empty space to expand status bar. Long press on clock to show system UI.",
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
                          RemixIcon.restart,
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
                            "to immediately refresh apps if needed, long press to force refresh.",
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
          );
        });
  }

  showGreetingTextEditDialog(context) {
    shelfState.flow.greetingTextController.text = shelfState.flow.greetingText;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ShelfTheme.of(context).colors.tertiary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                RemixIcon.sticky_note,
                color: ShelfTheme.of(context).colors.onTertiary,
                size: 50,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Edit Header",
                style: TextStyle(
                    color: ShelfTheme.of(context).colors.onTertiary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Card(
            color: ShelfTheme.of(context).colors.surface,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: shelfState.flow.greetingTextController,
                onChanged: (term) {
                  shelfState.flow.updateGreetingText(term);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: ShelfTheme.of(context).colors.primary,
                    fontSize: 20,
                  ),
                ),
                cursorColor: ShelfTheme.of(context).colors.primary,
                maxLines: null,
                style: TextStyle(
                  color: ShelfTheme.of(context).colors.primary,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 1,
      child: PageView(
        scrollDirection:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Axis.horizontal
                : Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onLongPress: () {
                showGreetingTextEditDialog(context);
              },
              onDoubleTap: () {
                showHintDialog(context);
              },
              child: Card(
                elevation: ShelfTheme.of(context).uiParameters.cardElevation,
                color: ShelfTheme.of(context)
                    .colors
                    .secondary
                    .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
                child: const Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: GreetingsWidget(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: ShelfTheme.of(context).uiParameters.cardElevation,
              color: ShelfTheme.of(context)
                  .colors
                  .surface
                  .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
              child: const QuickNote(),
            ),
          ),
        ],
      ),
    );
  }
}

class QuickNote extends StatelessWidget {
  const QuickNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: shelfState.flow.quickNoteController,
        onChanged: (term) {
          shelfState.flow.saveQuickNote(term);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "- Save a Quick Note here...",
          hintStyle: TextStyle(
            color: ShelfTheme.of(context).colors.primary,
            fontSize: 20,
          ),
        ),
        cursorColor: ShelfTheme.of(context).colors.primary,
        maxLines: null,
        style: TextStyle(
          color: ShelfTheme.of(context).colors.primary,
          fontSize: 20,
        ),
      ),
    );
  }
}

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: shelfState.flow.greetingTextStream.stream,
        builder: (context, snapshot) {
          final String greetingText =
              snapshot.data ?? shelfState.flow.greetingText;
          return Text(
            greetingText,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          );
        });
  }
}
