/// Template configuration file for the Weather App
///
/// To use this app:
/// 1. Copy this file to `app_config.dart`
/// 2. Replace 'YOUR_API_KEY_HERE' with your actual OpenWeatherMap API key
/// 3. Get your API key from: https://openweathermap.org/api

class AppConfig {
  /// OpenWeatherMap API key
  ///
  /// To get your API key:
  /// 1. Visit https://openweathermap.org/api
  /// 2. Sign up for a free account
  /// 3. Get your API key from the dashboard
  /// 4. Replace the value below with your actual API key
  static const String openWeatherMapApiKey = 'YOUR_API_KEY_HERE';

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
