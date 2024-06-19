import 'dart:async';

import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:shelf/ui/theming.dart';


StreamController<List<AppInfo>> allAppsListStream =
    StreamController.broadcast();

List<AppInfo> allAppsList = [];

String leadingWidget = "visualizer";
String leadingWidgetApp = "com.coleblvck.antiiq";

Map<String, Widget> widgets(context) => {
      "visualizer": MiniMusicVisualizer(
        animate: true,
        radius: 8,
        height: 24,
        width: 10,
        color: ShelfTheme.of(context).colors.onPrimary,
      ),
    };
