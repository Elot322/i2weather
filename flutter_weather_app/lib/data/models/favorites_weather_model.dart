import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';

class FavoritiesCitiesWeatherModel extends FavoriteCitiesWeatherEntity {
  const FavoritiesCitiesWeatherModel({
    required super.temp,
    required super.status,
    required super.description,
  });

  factory FavoritiesCitiesWeatherModel.fromJson(Map<String, dynamic> json) {
    return FavoritiesCitiesWeatherModel(
      temp: json['main']['temp'],
      status: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }
}
