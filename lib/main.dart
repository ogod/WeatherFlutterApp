import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/weather_viewmodel.dart';
import 'services/weather_service_impl.dart';
import 'services/location_store_impl.dart';
import 'pages/weather_page.dart';
import 'config/app_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherViewModel(
            WeatherService(AppConfig.openWeatherMapApiKey),
            LocationStore(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Weather Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}
