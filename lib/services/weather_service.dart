import '../models/weather_result.dart';

abstract class IWeatherService {
  /// Gets the current weather for the specified city.
  ///
  /// [city] City name.
  /// Returns WeatherResult object, or throws an exception if the city is not found or request fails.
  Future<WeatherResult> getWeatherAsync(String city);
}
