import 'package:flutter_weather_app/domain/entities/current_weather_entity.dart';

class CurrentCityWeatherModel extends CurrentWeatherInCityEntity {
  CurrentCityWeatherModel({
    required super.currentTemp,
    required super.feelsLikeTemp,
    required super.cloudsPercentage,
    required super.windSpeed,
    required super.status,
    required super.description,
  });

  factory CurrentCityWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentCityWeatherModel(
      currentTemp: json['main']['temp'],
      feelsLikeTemp: json['main']['feels_like'],
      cloudsPercentage: json['clouds']['all'],
      windSpeed: json['wind']['speed'].toDouble(),
      status: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }
}
