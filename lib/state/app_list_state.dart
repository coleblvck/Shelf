import 'dart:async';

import 'package:collection/collection.dart';

import '../../channels/app_scout/app_detail.dart';
import '../../channels/app_scout/app_scout.dart';

class AppListState {
  Function listEqualityCheck = const ListEquality().equals;
  List<AppDetail> list = [];
  StreamController<List<AppDetail>> stream = StreamController.broadcast();

  get({bool forceUpdate = false}) async {
    List<AppDetail> apps = await AppScout.fetchApps();
    apps.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    apps.removeWhere((app) => app.packageName == "com.coleblvck.shelf");
    if (!forceUpdate) {
      bool sameAsOld = listEqualityCheck(
          apps.map((e) => e.packageName).toList(),
          list.map((e) => e.packageName).toList());
      if (!sameAsOld) {
        stream.add(apps);
        list = apps;
      }
    } else {
      stream.add(apps);
      list = apps;
    }
  }
}
