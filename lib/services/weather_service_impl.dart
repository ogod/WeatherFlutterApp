import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_result.dart';
import '../config/app_config.dart';
import 'weather_service.dart';

/// Retrieves current weather information using the OpenWeatherMap API.
class WeatherService implements IWeatherService {
  final String _apiKey;
  final http.Client _httpClient;

  WeatherService(this._apiKey) : _httpClient = http.Client() {
    if (_apiKey.isEmpty) {
      throw ArgumentError('API key must not be empty');
    }
  }

  /// Retrieves the current weather for a specified city using the OpenWeatherMap API.
  ///
  /// [city] The name of the city to retrieve weather data for.
  /// Returns a WeatherResult containing weather information for the specified city.
  /// Throws ArgumentError when the city name is null, empty, or whitespace.
  /// Throws HttpException when the HTTP request to the OpenWeatherMap API fails or returns a non-success status code.
  /// Throws FormatException when the response JSON is invalid or deserialization fails.
  /// Throws StateError when the parsed weather data is unexpectedly null.
  @override
  Future<WeatherResult> getWeatherAsync(String city) async {
    if (city.trim().isEmpty) {
      throw ArgumentError('City name must not be null or empty');
    }

    final url = Uri.parse(
      '${AppConfig.weatherApiBaseUrl}?q=${Uri.encodeComponent(city)}&appid=$_apiKey&units=metric',
    );

    final response = await _httpClient.get(url);

    if (response.statusCode == 404) {
      throw StateError('City not found.');
    }

    if (response.statusCode != 200) {
      throw Exception(
        'API returned ${response.statusCode}: ${response.reasonPhrase}',
      );
    }

    try {
      final json = jsonDecode(response.body);
      final weather = WeatherResult.fromJson(json);

      if (weather.cityName == null) {
        throw StateError('Failed to deserialize weather data.');
      }

      return weather;
    } catch (e) {
      if (e is FormatException) {
        throw FormatException('Failed to parse weather data: $e');
      }
      rethrow;
    }
  }

  void dispose() {
    _httpClient.close();
  }
}
