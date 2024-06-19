import 'package:flutter/material.dart';
import 'package:shelf/utilities/shelf_utils.dart';
import 'package:timer_builder/timer_builder.dart';

import '../ui/theming.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        toggleSystemUIMode();
      },
      onTap: () {
        expandNotificationBar();
      },
      child: Card(
        elevation: ShelfTheme.of(context).uiParameters.cardElevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: ShelfTheme.of(context)
            .colors
            .secondary
            .withAlpha(ShelfTheme.of(context).uiParameters.cardAlpha),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (context) {
              return Text(
                getCurrentTime(),
                style: TextStyle(
                  decoration: TextDecoration.none,
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: ShelfTheme.of(context).colors.onSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: ShelfTheme.of(context).colors.onSecondary,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
