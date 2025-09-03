# Weather Flutter App

A Flutter weather application that provides current weather information for cities using the OpenWeatherMap API. This app is a Flutter reproduction of a MAUI weather application.

## Features

- **Current Weather Display**: Shows temperature, humidity, and weather description
- **City Search**: Search for weather by city name
- **Saved Cities**: Dropdown to select from previously searched cities
- **Auto-refresh**: Automatically refreshes weather data every 10 minutes
- **Background Images**: Dynamic weather-themed backgrounds based on current conditions
- **Local Storage**: Saves searched cities using SharedPreferences
- **Error Handling**: Comprehensive error handling for API failures and invalid inputs

## Screenshots

The app features a clean, card-based design with:
- City selection card with dropdown and text input
- Weather information card displaying current conditions
- Status section showing loading states and error messages
- Dynamic background images based on weather conditions

## Setup Instructions

### Prerequisites

- Flutter SDK (version 3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- OpenWeatherMap API key

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd weather_flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Get OpenWeatherMap API Key**
   - Visit [OpenWeatherMap](https://openweathermap.org/api)
   - Sign up for a free account
   - Get your API key from the dashboard

4. **Configure API Key**
   - Open `lib/main.dart`
   - Replace `'YOUR_API_KEY_HERE'` with your actual API key:
   ```dart
   WeatherService('YOUR_ACTUAL_API_KEY'),
   ```

5. **Add Weather Images** (Optional)
   - Place weather background images in `assets/images/`
   - See `assets/images/README.md` for required image names
   - If no images are provided, the app will work without backgrounds

6. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point with provider setup
├── models/
│   └── weather_result.dart   # Weather data models
├── services/
│   ├── weather_service.dart      # Weather service interface
│   ├── weather_service_impl.dart # OpenWeatherMap API implementation
│   ├── location_store.dart       # Location storage interface
│   └── location_store_impl.dart  # SharedPreferences implementation
├── viewmodels/
│   └── weather_viewmodel.dart    # Business logic and state management
└── pages/
    └── weather_page.dart         # Main UI page
```

## Dependencies

- **http**: For API requests to OpenWeatherMap
- **shared_preferences**: For local storage of saved cities
- **provider**: For state management and dependency injection

## API Usage

The app uses the OpenWeatherMap Current Weather API:
- **Endpoint**: `https://api.openweathermap.org/data/2.5/weather`
- **Units**: Metric (Celsius)
- **Rate Limit**: Free tier allows 1000 calls/day

## Architecture

The app follows the MVVM (Model-View-ViewModel) pattern:

- **Models**: Data classes for weather information
- **Services**: API calls and local storage
- **ViewModels**: Business logic and state management
- **Views**: UI components using Flutter widgets

## State Management

Uses Provider pattern with ChangeNotifier for reactive UI updates:
- Weather data changes trigger UI updates
- Loading states are managed centrally
- Error handling provides user feedback

## Local Storage

Cities are saved using SharedPreferences:
- JSON serialization for city lists
- Automatic loading on app startup
- Duplicate prevention

## Error Handling

Comprehensive error handling for:
- Network failures
- Invalid city names
- API rate limiting
- JSON parsing errors
- Storage failures

## Customization

### Themes
- Modify `ThemeData` in `main.dart`
- Change color schemes and typography

### Weather Images
- Replace images in `assets/images/`
- Adjust opacity in `weather_page.dart`

### API Configuration
- Change base URL in `weather_service_impl.dart`
- Modify units (metric/imperial)
- Add additional API parameters

## Troubleshooting

### Common Issues

1. **API Key Error**
   - Ensure API key is correctly set in `main.dart`
   - Check API key validity on OpenWeatherMap dashboard

2. **No Weather Data**
   - Verify city name spelling
   - Check internet connectivity
   - Ensure API key has sufficient quota

3. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter version compatibility

4. **Missing Images**
   - App works without weather images
   - Check image file names match exactly

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).

## Acknowledgments

- OpenWeatherMap for providing the weather API
- Flutter team for the excellent framework
- MAUI community for the original app design inspiration
