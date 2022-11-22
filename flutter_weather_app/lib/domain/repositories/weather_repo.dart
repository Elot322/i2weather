import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/entities/current_weather_entity.dart';
import 'package:flutter_weather_app/domain/entities/daily_forecast_entity.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';
import 'package:flutter_weather_app/domain/entities/hourly_forecast_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeatherInCityEntity>> getWeather(
      CityEntity city);
  Future<Either<Failure, FavoriteCitiesWeatherEntity>> getFavoriteWeather(
      CityEntity city);
  Future<Either<Failure, Set<FiveDaysForecastEntity>>> getDailyForecast(
      CityEntity city);
  Future<Either<Failure, List<HourlyForecastEntity>>> getHourlyForecast(
      CityEntity city);
}
