import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';

class FavoritiesCitiesWeatherModel extends FavoriteCitiesWeatherEntity {
  FavoritiesCitiesWeatherModel({
    required super.temp,
    required super.status,
    required super.description,
  });

  factory FavoritiesCitiesWeatherModel.fromJson(Map<String, dynamic> json) {
    return FavoritiesCitiesWeatherModel(
      temp: json['main']['temp'],
      status: json['weather']['main'],
      description: json['weather']['description'],
    );
  }
}
