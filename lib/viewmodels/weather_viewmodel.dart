import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/weather_result.dart';
import '../services/weather_service.dart';
import '../services/location_store.dart';
import '../config/app_config.dart';

class WeatherViewModel extends ChangeNotifier {
  final IWeatherService _weatherService;
  final ILocationStore _locationStore;
  Timer? _refreshTimer;

  String? _city;
  WeatherResult? _weather;
  String? _error;
  String? _selectedCity;
  bool _isBusy = false;
  bool _showFetched = false;
  List<String> _savedCities = [];

  WeatherViewModel(this._weatherService, this._locationStore) {
    _loadSavedCitiesAsync();
  }

  // Getters
  String? get city => _city;
  WeatherResult? get weather => _weather;
  String? get error => _error;
  String? get selectedCity => _selectedCity;
  bool get isBusy => _isBusy;
  bool get showFetched => _showFetched;
  List<String> get savedCities => List.unmodifiable(_savedCities);

  String get weatherBackgroundImage {
    final weatherMain = weather?.weather?.firstOrNull?.main;
    switch (weatherMain) {
      case 'Clear':
        return 'assets/images/sunny.png';
      case 'Clouds':
        return 'assets/images/cloudy.png';
      case 'Rain':
      case 'Drizzle':
        return 'assets/images/rainy.png';
      case 'Thunderstorm':
        return 'assets/images/stormy.png';
      case 'Snow':
        return 'assets/images/snowy.png';
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
      case 'Sand':
      case 'Ash':
        return 'assets/images/foggy.png';
      case 'Squall':
        return 'assets/images/windy.png';
      case 'Tornado':
        return 'assets/images/stormy.png';
      default:
        return 'assets/images/default.png';
    }
  }

  double? get temperature => weather?.main?.temperature;
  int? get humidity => weather?.main?.humidity;
  String? get description => weather?.weather?.firstOrNull?.description;

  // Setters
  set city(String? value) {
    _city = value;
    notifyListeners();
  }

  set selectedCity(String? value) {
    if (_selectedCity != value) {
      _selectedCity = value;
      _city = value;
      notifyListeners();

      if (value == null || value.trim().isEmpty) {
        _weather = null;
        _error = null;
        _stopRefreshTimer();
      } else {
        getWeatherAsync();
        _startRefreshTimer();
      }
    }
  }

  set weather(WeatherResult? value) {
    _weather = value;
    notifyListeners();
  }

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  set showFetched(bool value) {
    _showFetched = value;
    notifyListeners();
  }

  Future<void> getWeatherAsync() async {
    if (_isBusy) return;

    _isBusy = true;
    _showFetched = false;
    _error = null;
    notifyListeners();

    if (_city == null || _city!.trim().isEmpty) {
      _error = "Please enter a city name.";
      _isBusy = false;
      notifyListeners();
      return;
    }

    try {
      _weather = await _weatherService.getWeatherAsync(_city!);
      await _locationStore.saveLocationAsync(_city!);

      if (!_savedCities.contains(_city!)) {
        _savedCities.add(_city!);
        notifyListeners();
      }

      _showFetched = true;
      notifyListeners();

      await Future.delayed(
        Duration(milliseconds: AppConfig.weatherConfirmationDurationMs),
      );
      _showFetched = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  Future<void> _loadSavedCitiesAsync() async {
    try {
      final cities = await _locationStore.loadLocationsAsync();
      _savedCities = cities;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading saved cities: $e');
    }
  }

  void _startRefreshTimer() {
    _stopRefreshTimer();
    _refreshTimer = Timer.periodic(
      Duration(minutes: AppConfig.weatherRefreshIntervalMinutes),
      (timer) {
        if (_city != null && _city!.isNotEmpty) {
          getWeatherAsync();
        }
      },
    );
  }

  void _stopRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  @override
  void dispose() {
    _stopRefreshTimer();
    super.dispose();
  }
}
