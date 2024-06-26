import 'package:flutter/material.dart';
import 'package:shelf/state/flow_state.dart';
import 'package:shelf/state/state_util.dart';
import 'package:shelf/utilities/dialogs/header_edit.dart';
import 'package:shelf/utilities/dialogs/hint.dart';
import 'package:shelf/ui/theming.dart';

class ShelfFlow extends StatelessWidget {
  ShelfFlow({
    super.key,
  });

  final FlowState state = shelfState.flow;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 1,
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        pageSnapping: false,
        controller: state.controller,
        onPageChanged: (index) {
          state.onPageChanged(index);
        },
        scrollDirection:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Axis.horizontal
                : Axis.vertical,
        itemCount: state.itemCount,
        itemBuilder: (context, index) {
          return state.cards[index % state.cardCount];
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: ShelfTheme.of(context).uiParameters.cardElevation,
        color: ShelfTheme.of(context)
            .colors
            .surface
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: const QuickNote(),
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onLongPress: () {
          headerTextEditDialog(context);
        },
        onDoubleTap: () {
          showHintDialog(context);
        },
        child: Card(
          elevation: ShelfTheme.of(context).uiParameters.cardElevation,
          color: ShelfTheme.of(context)
              .colors
              .surface
              .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
          child: const Center(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Greetings(),
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

class Greetings extends StatelessWidget {
  const Greetings({
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
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w900,
              color: ShelfTheme.of(context).colors.onSurface,
            ),
            textAlign: TextAlign.center,
          );
        });
  }
}
