/// Interface for saving and retrieving user-searched locations.
/// Enables pluggable storage mechanisms (e.g., file, DB, in-memory).
abstract class ILocationStore {
  /// Loads previously saved locations asynchronously.
  ///
  /// Returns List of saved city names.
  Future<List<String>> loadLocationsAsync();

  /// Saves a new location asynchronously.
  ///
  /// [location] City name to be saved.
  Future<void> saveLocationAsync(String location);
}
