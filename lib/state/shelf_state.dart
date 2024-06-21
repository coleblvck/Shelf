import 'dart:async';

import 'package:shelf/state/drawer_state.dart';
import 'package:shelf/state/flow_state.dart';
import 'package:shelf/state/pages_state.dart';
import 'package:shelf/state/search_state.dart';
import 'package:shelf/state/system_ui_mode_state.dart';
import 'package:shelf/utilities/user_prefs.dart';

import '../ui/theming.dart';
import 'app_list_state.dart';
import 'dashboard_state.dart';

class ShelfState {
  AppListState apps = AppListState();
  SystemUiDisplayState uiMode = SystemUiDisplayState();
  DashboardState dashboard = DashboardState();
  PagesState pages = PagesState();
  DrawerState drawer = DrawerState();
  SearchState search = SearchState();
  FlowState flow = FlowState();

  List<bool> isShelfRefreshing = [false, false];
  StreamController<List<bool>> isShelfRefreshingStream =
      StreamController.broadcast();

  refreshShelf({bool forceUpdate = false}) async {
    updateRefreshProcess(true, forceUpdate);
    await refreshColorScheme();
    await apps.get(forceUpdate: forceUpdate);
    updateRefreshProcess(false, false);
  }

  initShelf() async {
    await initColorScheme();
    initUserPrefs();
    initApps();
  }

  initUserPrefs() async {
    final bool? flowVisible = userPrefs.getBool(PrefKeys.flowVisible);
    final bool? systemUiVisible = userPrefs.getBool(PrefKeys.systemUiVisible);
    final bool? dashboardVisible = userPrefs.getBool(PrefKeys.dashboardVisible);
    final String? greetingText = userPrefs.getString(PrefKeys.greetingText);
    final String? quickNoteText = userPrefs.getString(PrefKeys.quickNoteText);
    final String? drawerLayout = userPrefs.getString(PrefKeys.drawerLayout);
    if (flowVisible != null) {
      flow.updateVisibility(flowVisible, save: false);
    }
    uiMode.setSystemUIMode(systemUiVisible ?? false, save: false);

    if (dashboardVisible != null) {
      dashboard.updateVisibility(dashboardVisible, save: false);
    }
    if (greetingText != null) {
      flow.updateGreetingText(greetingText, save: false);
    }
    if (quickNoteText != null) {
      flow.quickNoteController.text = quickNoteText;
    }
    if (drawerLayout != null) {
      drawer.updateLayout(drawerLayout, save: false);
    }
  }

  updateRefreshProcess(bool isRefreshing, bool forceUpdate) {
    isShelfRefreshing = [isRefreshing, forceUpdate];
    isShelfRefreshingStream.add([isRefreshing, forceUpdate]);
  }

  initApps() async {
    await apps.get();
  }
}