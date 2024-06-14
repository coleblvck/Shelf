import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/widgets/app_list.dart';
import 'package:shelf/widgets/blinders.dart';
import 'package:shelf/widgets/boxes.dart';
import 'package:shelf/widgets/peek_box.dart';

Widget desktopBox1Child = const PeekBox();
Widget desktopBox2Child = Container(); //const AppListBuilder();
bool fabEnabled = true;
String greetingText = "Hola";
String fabApp = "com.coleblvck.antiiq";
String layout = "Blinders";
bool menuShowsListOnHome = true;
bool menuShown = false;
TextEditingController searchController = TextEditingController();

StreamController<List<AppInfo>> allAppsListStream =
    StreamController.broadcast();

List<AppInfo> allAppsList = [];

Map<String, Map<String, dynamic>> actionButtonActions(context) => {
      "visualizer": {
        "widget": MiniMusicVisualizer(
          animate: true,
          radius: 5,
          height: 20,
          width: 10,
          color: ShelfTheme.of(context).colors.secondary,
        ),
        "function": () {
          if (allAppsList.map((e) => e.packageName).toList().contains(fabApp)) {
            InstalledApps.startApp(fabApp);
          }
        },
      }
    };
