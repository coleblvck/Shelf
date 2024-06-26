import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/channels/app_scout/app_scout.dart';
import 'package:shelf/state/drawer_state.dart';
import 'package:shelf/state/flow_state.dart';
import 'package:shelf/state/pages_state.dart';
import 'package:shelf/state/parallax_state.dart';
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
  ParallaxState parallax = ParallaxState();

  refreshShelf({bool forceUpdate = false}) async {
    //await refreshColorScheme();
    await apps.get(forceUpdate: forceUpdate);
  }

  initShelf() async {
    pages.init();
    flow.init();
    await initColorScheme();
    userPrefs = await SharedPreferences.getInstance();
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
    final bool? parallaxStatus = userPrefs.getBool(PrefKeys.parallaxStatus);
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
    if (parallaxStatus != null) {
      ParallaxStatus status =
          parallaxStatus ? ParallaxStatus.falling : ParallaxStatus.off;
      parallax.setStatus(status, save: false);
    }
  }

  initApps() async {
    await apps.get();
    AppScout.initScoutListen();
  }
}
