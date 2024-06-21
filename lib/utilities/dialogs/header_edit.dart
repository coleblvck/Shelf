
import 'package:flutter/material.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';

import '../../state/state_util.dart';
import '../../ui/theming.dart';

headerTextEditDialog(context) {
  shelfState.flow.greetingTextController.text = shelfState.flow.greetingText;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ShelfTheme.of(context).colors.tertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
