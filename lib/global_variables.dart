import 'dart:async';

import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/widgets/peek_box.dart';

Widget desktopBox1Child = const PeekBox();
Widget desktopBox2Child = Container(); //const AppListBuilder();
bool fabEnabled = false;
String greetingText = "Hola";
String fabApp = "com.coleblvck.antiiq";
String drawerLayout = "Boxes";
StreamController<String> drawerLayoutStream = StreamController.broadcast();
bool menuShowsListOnHome = true;
bool menuShown = false;

StreamController<List<AppInfo>> allAppsListStream =
    StreamController.broadcast();

List<AppInfo> allAppsList = [];

String currentActionWidgetAction = "visualizer";

Map<String, Map<String, dynamic>> widgetsWithActions(context) => {
      "visualizer": {
        "widget": MiniMusicVisualizer(
          animate: true,
          radius: 8,
          height: 24,
          width: 10,
          color: ShelfTheme.of(context).colors.onPrimary,
        ),
      }
    };
