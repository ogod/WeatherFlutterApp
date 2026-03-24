import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../config/app_config.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  viewModel.weather != null
                      ? viewModel.weatherBackgroundImage
                      : 'assets/images/default.png',
                ),
                fit: BoxFit.cover,
                opacity: AppConfig.backgroundImageOpacity,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // App Title
                    const Text(
                      'Weather Flutter',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // City Selection Card
                    _buildCitySelectionCard(viewModel),

                    const SizedBox(height: 24),

                    // Weather Info Card
                    if (viewModel.city != null && viewModel.city!.isNotEmpty)
                      _buildWeatherInfoCard(viewModel),

                    const SizedBox(height: 24),

                    // Status and Error Section
                    if (viewModel.isBusy ||
                        viewModel.error != null ||
                        viewModel.showFetched)
                      _buildStatusSection(viewModel),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCitySelectionCard(WeatherViewModel viewModel) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select or enter a city',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // City Picker
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: viewModel.selectedCity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    hint: const Text('Select city'),
                    items: viewModel.savedCities.map((city) {
                      return DropdownMenuItem(value: city, child: Text(city));
                    }).toList(),
                    onChanged: (value) {
                      viewModel.selectedCity = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // City Entry
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Or enter city',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        viewModel.city = value.trim();
                        viewModel.getWeatherAsync();
                        _cityController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfoCard(WeatherViewModel viewModel) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            // Weather Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weather for ${viewModel.city}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (viewModel.temperature != null)
                    Text(
                      'Temp: ${viewModel.temperature!.toStringAsFixed(1)}°C',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (viewModel.humidity != null)
                    Text(
                      'Humidity: ${viewModel.humidity}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (viewModel.description != null)
                    Text(
                      'Description: ${viewModel.description}',
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
            // Refresh Button
            IconButton(
              onPressed: viewModel.isBusy
                  ? null
                  : () => viewModel.getWeatherAsync(),
              icon: const Icon(Icons.refresh, size: 36, color: Colors.blue),
              tooltip: 'Refresh weather',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(WeatherViewModel viewModel) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFE9FBF8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            if (viewModel.error != null)
              Text(
                viewModel.error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            if (viewModel.isBusy) ...[
              const SizedBox(height: 6),
              const CircularProgressIndicator(),
            ],
            if (viewModel.showFetched)
              const Text(
                'Weather updated!',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
