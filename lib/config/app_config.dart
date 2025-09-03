/// Application configuration constants
///
/// For production use, set the OPENWEATHERMAP_API_KEY environment variable
/// or create a local app_config_local.dart file with your API key

// Try to import local config (this file is excluded from version control)
// ignore: avoid_web_libraries_in_flutter
import 'app_config_local.dart'
    if (dart.library.html) 'app_config_local_web.dart';

class AppConfig {
  /// OpenWeatherMap API key
  ///
  /// Priority order:
  /// 1. Environment variable OPENWEATHERMAP_API_KEY
  /// 2. Local config file (if exists)
  /// 3. Fallback to template value
  static String get openWeatherMapApiKey {
    // Try to get from environment variable first
    const envKey = String.fromEnvironment('OPENWEATHERMAP_API_KEY');
    if (envKey.isNotEmpty) {
      return envKey;
    }

    // Try to get from local config file
    try {
      return AppConfigLocal.openWeatherMapApiKey;
    } catch (e) {
      // Local config not available, fallback to template value
      return 'YOUR_API_KEY_HERE';
    }
  }

  /// Weather API base URL
  static const String weatherApiBaseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  /// Weather data refresh interval in minutes
  static const int weatherRefreshIntervalMinutes = 10;

  /// Weather confirmation display duration in milliseconds
  static const int weatherConfirmationDurationMs = 1500;

  /// Background image opacity
  static const double backgroundImageOpacity = 0.25;
}
