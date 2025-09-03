class WeatherResult {
  final String? cityName;
  final MainInfo? main;
  final List<WeatherDescription>? weather;

  WeatherResult({this.cityName, this.main, this.weather});

  factory WeatherResult.fromJson(Map<String, dynamic> json) {
    return WeatherResult(
      cityName: json['name'],
      main: json['main'] != null ? MainInfo.fromJson(json['main']) : null,
      weather: json['weather'] != null
          ? List<WeatherDescription>.from(
              json['weather'].map((x) => WeatherDescription.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': main?.toJson(),
      'weather': weather?.map((x) => x.toJson()).toList(),
    };
  }
}

class MainInfo {
  final double temperature;
  final int humidity;

  MainInfo({required this.temperature, required this.humidity});

  factory MainInfo.fromJson(Map<String, dynamic> json) {
    return MainInfo(
      temperature: (json['temp'] as num).toDouble(),
      humidity: json['humidity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'temp': temperature, 'humidity': humidity};
  }
}

class WeatherDescription {
  final String? description;
  final String? main;

  WeatherDescription({this.description, this.main});

  factory WeatherDescription.fromJson(Map<String, dynamic> json) {
    return WeatherDescription(
      description: json['description'],
      main: json['main'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'description': description, 'main': main};
  }
}
