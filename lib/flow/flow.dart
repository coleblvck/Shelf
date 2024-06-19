import 'dart:async';

import 'package:flutter/material.dart';

import '../ui/theming.dart';

String greetingText = "YOLO";
final TextEditingController quickNoteTextController = TextEditingController();

bool flowVisible = true;
StreamController<bool> flowVisibilityStream = StreamController.broadcast();

updateFlowVisibility(bool isVisible) {
  flowVisible = isVisible;
  flowVisibilityStream.add(isVisible);
}

toggleFlowVisibility() {
  updateFlowVisibility(!flowVisible);
}

class ShelfFlow extends StatelessWidget {
  const ShelfFlow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: PageView(
        scrollDirection:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Axis.horizontal
                : Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      child: Center(
                        child: GreetingsWidget(),
                      ),
                    ),
                  ],
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


  saveQuickNote(term) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: quickNoteTextController,
        onChanged: (term) => saveQuickNote,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Start typing to save Quick Note...",
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
    return Text(
      greetingText,
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
