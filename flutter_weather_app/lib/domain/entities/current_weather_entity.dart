import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/weather.dart';

class CurrentWeatherInCityEntity extends Equatable {
  final double currentTemp;
  final double feelsLikeTemp;
  final int cloudsPercentage;
  final double windSpeed;
  final String status;
  final String description;

  CurrentWeatherInCityEntity({
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.cloudsPercentage,
    required this.windSpeed,
    required this.status,
    required this.description,
  });

  @override
  List<Object?> get props => [];
}

class CurrentEntity extends Equatable {
  final double currentTemp;
  final double feelsLikeTemp;
  final int cloudsPercentage;
  final double windSpeed;
  final Weather weather;

  const CurrentEntity({
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.cloudsPercentage,
    required this.windSpeed,
    required this.weather,
  });

  @override
  List<Object?> get props => [
        currentTemp,
        feelsLikeTemp,
        cloudsPercentage,
        windSpeed,
        weather,
      ];
}
