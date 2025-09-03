import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_store.dart';

/// Stores and retrieves user-searched locations using SharedPreferences.
class LocationStore implements ILocationStore {
  static const String _key = 'saved_cities';

  @override
  Future<List<String>> loadLocationsAsync() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final citiesJson = prefs.getString(_key);

      if (citiesJson == null) {
        return <String>[];
      }

      final cities = List<String>.from(jsonDecode(citiesJson));
      return cities;
    } catch (e) {
      // Handle corrupted JSON or IO errors gracefully
      return <String>[];
    }
  }

  @override
  Future<void> saveLocationAsync(String location) async {
    try {
      final locations = await loadLocationsAsync();

      if (!locations.contains(location)) {
        locations.add(location);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_key, jsonEncode(locations));
      }
    } catch (e) {
      // Handle storage errors gracefully
      debugPrint('Error saving location: $e');
    }
  }
}
