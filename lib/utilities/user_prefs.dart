import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys{
  static String flowVisible = "flowVisible";
  static String systemUiVisible = "systemUiVisible";
  static String dashboardVisible = "dashboardVisible";
  static String greetingText = "greetingText";
  static String quickNoteText = "quickNoteText";
  static String drawerLayout  = "drawerLayout";
  static String parallaxStatus = "parallaxStatus";
}

late SharedPreferences userPrefs;