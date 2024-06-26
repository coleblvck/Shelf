import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:remix_icon_icons/remix_icon_icons.dart';
import 'package:shelf/channels/app_scout/app_scout.dart';
import 'package:shelf/state/state_util.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/dialogs/functions_mapping.dart';
import 'package:shelf/utilities/user_prefs.dart';

class WidgetKeys {
  static const String visualizer = "visualizer";
  static const String music = "music";
  static const String pencil = "pencil";
  static const String firefox = "firefox";
  static const String fire = "fire";
  static const String thunderstorms = "thunderstorms";
  static const String trafficLight = "trafficLight";
  static const String lightbulb = "lightbulb";
  static const String spaceShip = "spaceShip";
  static const String chat = "chat";
  static const String chat2 = "chat2";
  static const String game = "game";
  static const String gamePad = "gamePad";
  static const String settings = "settings";
}

class BehaviourKeys {
  static const String launch = "launch App";
  static const String action = "Action";
  static const String none = "None";
}

class CustomFunctions {
  run(BuildContext context) async {
    if (currentBehaviour == BehaviourKeys.launch && shelfState.apps.list.isNotEmpty) {
      if (shelfState.apps.list
          .map((e) => e.packageName)
          .toList()
          .contains(currentPackage)) {
        AppScout.launchApp(currentPackage);
      } else {
        functionMappingDialog(context);
      }
    }
  }

  updateCustomBehavior({
    String widget = "",
    String package = "",
    String behaviour = "",
    bool save = true,
  }) async {
    if (widget != "") {
      updateWidget(widget);
    }
    if (package != "") {
      updatePackage(package);
    }

    if (behaviour != "") {
      updateAction(behaviour);
    }
    if (save) {
      await _save(
        widget: widget,
        package: package,
        behaviour: behaviour,
      );
    }
  }

  updateWidget(String widget) {
    currentWidget = widget;
    widgetStream.add(widgets[widget]!);
  }

  updatePackage(String package) {
    currentPackage = package;
  }

  updateAction(String action) {
    currentBehaviour = action;
    widgetStream.add(widgets[currentWidget]!);
  }

  _save({
    String widget = "",
    String package = "",
    String behaviour = "",
  }) async {
    if (widget != "") {
      await userPrefs.setString(PrefKeys.customWidget, widget);
    }
    if (package != "") {
      await userPrefs.setString(PrefKeys.customPackage, package);
    }
    if (behaviour != "") {
      await userPrefs.setString(PrefKeys.customBehaviour, behaviour);
    }
  }

  StreamController<Widget> widgetStream = StreamController.broadcast();
  String currentWidget = WidgetKeys.visualizer;
  String currentPackage = "com.coleblvck.antiiq";
  String currentBehaviour = BehaviourKeys.launch;

  List<String> functionKeys = [
    BehaviourKeys.launch,
    BehaviourKeys.action,
  ];

  List<String> widgetKeys = [
    WidgetKeys.visualizer,
    WidgetKeys.music,
    WidgetKeys.pencil,
    WidgetKeys.firefox,
    WidgetKeys.fire,
    WidgetKeys.thunderstorms,
    WidgetKeys.trafficLight,
    WidgetKeys.lightbulb,
    WidgetKeys.spaceShip,
    WidgetKeys.chat,
    WidgetKeys.chat2,
    WidgetKeys.game,
    WidgetKeys.gamePad,
    WidgetKeys.settings,
  ];

  Map<String, Widget> widgets = {
    "visualizer": MiniMusicVisualizer(
      animate: true,
      radius: 8,
      height: 24,
      width: 10,
      color: currentColorScheme.onPrimary,
    ),
    "music": Icon(
      RemixIcon.music,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "pencil": Icon(
      RemixIcon.pencil,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "firefox": Icon(
      RemixIcon.firefox,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "fire": Icon(
      RemixIcon.fire,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "thunderstorms": Icon(
      RemixIcon.thunderstorms,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "trafficLight": Icon(
      RemixIcon.traffic_light,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "lightbulb": Icon(
      RemixIcon.lightbulb,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "spaceShip": Icon(
      RemixIcon.space_ship,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "chat": Icon(
      RemixIcon.chat_1,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "chat2": Icon(
      RemixIcon.chat_3,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "game": Icon(
      RemixIcon.game,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "gamePad": Icon(
      RemixIcon.gamepad,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
    "settings": Icon(
      RemixIcon.settings_3,
      color: currentColorScheme.onPrimary,
      size: 30,
    ),
  };
}
