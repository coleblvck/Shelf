import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String flowVisible = "flowVisible";
  static const String systemUiVisible = "systemUiVisible";
  static const String dashboardVisible = "dashboardVisible";
  static const String greetingText = "greetingText";
  static const String quickNoteText = "quickNoteText";
  static const String drawerLayout = "drawerLayout";
  static const String parallaxStatus = "parallaxStatus";
  // Custom Functions
  static const String customWidget = "customWidget";
  static const String customPackage = "customPackage";
  static const String customBehaviour = "customBehaviour";
}

late SharedPreferences userPrefs;
