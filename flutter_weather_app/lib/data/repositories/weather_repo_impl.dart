import 'package:either_dart/src/either.dart';
import 'package:flutter_weather_app/core/error/exception.dart';
import 'package:flutter_weather_app/data/data_source/api/weather_api_datasource.dart';
import 'package:flutter_weather_app/data/data_source/local/sities_local_datasource.dart';
import 'package:flutter_weather_app/data/models/city_model.dart';
import 'package:flutter_weather_app/data/models/current_weather_model.dart';
import 'package:flutter_weather_app/data/models/five_days_forecast_model.dart';
import 'package:flutter_weather_app/domain/entities/hourly_forecast_entity.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';
import 'package:flutter_weather_app/domain/entities/daily_forecast_entity.dart';
import 'package:flutter_weather_app/domain/entities/current_weather_entity.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repo.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherApiDatasource weatherApiDatasource;
  final CitiesLocalDatasource citiesLocalDatasource;

  WeatherRepositoryImpl({
    required this.weatherApiDatasource,
    required this.citiesLocalDatasource,
  });

  @override
  Future<Either<Failure, Set<FiveDaysForecastEntity>>> getDailyForecast(
      CityEntity city,
      [String apiKey = '']) async {
    return await _getWeatherOnFiveDay(
        CityModel(cityName: city.cityName), apiKey);
  }

  @override
  Future<Either<Failure, FavoriteCitiesWeatherEntity>> getFavoriteWeather(
      CityEntity city,
      [String apiKey = '']) async {
    return await _getFavoriteWeather(
        CityModel(cityName: city.cityName), apiKey);
  }

  @override
  Future<Either<Failure, List<HourlyForecastEntity>>> getHourlyForecast(
      CityEntity city,
      [String apiKey = '']) async {
    return await _getHourlyWeather(CityModel(cityName: city.cityName), apiKey);
  }

  @override
  Future<Either<Failure, CurrentWeatherInCityEntity>> getWeather(
      CityEntity city,
      [String apiKey = '']) async {
    return await _getCurrentWeather(CityModel(cityName: city.cityName), apiKey);
  }

  Future<Either<Failure, Set<FiveDaysForecastModel>>> _getWeatherOnFiveDay(
      CityModel cityModel, String apiKey) async {
    //final apiKey = apiKeyLocalDatasource.getApiKeyFromEnv();
    try {
      final list = await weatherApiDatasource.getCurrentCityFiveDaysWeather(
          cityModel, apiKey);
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, FavoriteCitiesWeatherEntity>> _getFavoriteWeather(
      CityModel cityModel, String apiKey) async {
    try {
      final cityData =
          await weatherApiDatasource.getFavoriteCityWeather(cityModel, apiKey);
      return Right(cityData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<HourlyForecastEntity>>> _getHourlyWeather(
      CityModel cityModel, String apiKey) async {
    try {
      final cityData = await weatherApiDatasource.getCurrentCityHourlyWeather(
          cityModel, apiKey);
      return Right(cityData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CurrentCityWeatherModel>> _getCurrentWeather(
      CityModel cityModel, String apiKey) async {
    try {
      final cityData =
          await weatherApiDatasource.getCurrentWeather(cityModel, apiKey);
      return Right(cityData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
