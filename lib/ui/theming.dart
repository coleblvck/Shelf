import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class ShelfColorScheme {
  const ShelfColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.surface,
    required this.onSurface,
    required this.brightness,
    required this.colorSchemeType,
  });
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color surface;
  final Color onSurface;
  final Brightness brightness;
  final ColorSchemeType colorSchemeType;
}

enum ColorSchemeType { shelf, dynamic }

ShelfColorScheme defaultColors = ShelfColorScheme(
  primary: Colors.orange,
  onPrimary: Colors.black,
  secondary: Colors.purple.withBlue(10),
  onSecondary: Colors.black,
  surface: Colors.black,
  onSurface: Colors.white,
  brightness: Brightness.dark,
  colorSchemeType: ColorSchemeType.shelf,
);

class UIParameters {
  const UIParameters({
    required this.cardElevation,
    required this.cardAlpha,
  });
  final double cardElevation;
  final int cardAlpha;
}

UIParameters defaultUIParameters = const UIParameters(
  cardElevation: 5,
  cardAlpha: 450,
);

class ShelfTheme extends InheritedWidget {
  const ShelfTheme({
    super.key,
    required super.child,
    required this.colors,
    required this.uiParameters,
  });

  final ShelfColorScheme colors;
  final UIParameters uiParameters;

  static ShelfTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShelfTheme>();
  }

  static ShelfTheme of(BuildContext context) {
    final ShelfTheme? result = maybeOf(context);
    assert(result != null, 'No ShelfTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ShelfTheme oldWidget) {
    return oldWidget.colors != colors;
  }
}

ShelfColorScheme? currentColorScheme;

StreamController<ShelfColorScheme> colorSchemeStream =
    StreamController.broadcast();

getColorScheme() async {
  final corePalette = await DynamicColorPlugin.getCorePalette();
  if (corePalette != null) {
    ColorScheme dynamicColors =
        corePalette.toColorScheme(brightness: Brightness.dark);
    ShelfColorScheme dynamicColorScheme = ShelfColorScheme(
      primary: dynamicColors.primary,
      onPrimary: dynamicColors.onPrimary,
      secondary: dynamicColors.tertiary,
      onSecondary: dynamicColors.onTertiary,
      surface: dynamicColors.surface,
      onSurface: dynamicColors.onSurface,
      brightness: Brightness.dark,
      colorSchemeType: ColorSchemeType.dynamic,
    );
    colorSchemeStream.add(dynamicColorScheme);
    currentColorScheme = dynamicColorScheme;
  } else {
    colorSchemeStream.add(defaultColors);
    currentColorScheme = defaultColors;
  }
}

initColorScheme() async {
  await getColorScheme();
}

refreshColorScheme() async {
  await getColorScheme();
}
