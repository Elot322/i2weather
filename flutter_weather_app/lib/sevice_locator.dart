import 'package:flutter_weather_app/data/repositories/api_key_repo_impl.dart';
import 'package:flutter_weather_app/data/repositories/cities_repo_impl.dart';
import 'package:flutter_weather_app/data/repositories/weather_repo_impl.dart';
import 'package:flutter_weather_app/domain/repositories/api_key_repo.dart';
import 'package:flutter_weather_app/domain/repositories/city_repo.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repo.dart';
import 'package:flutter_weather_app/domain/usecases/api/get_api_key.dart';
import 'package:flutter_weather_app/domain/usecases/city/add_to_favorite_city.dart';
import 'package:flutter_weather_app/domain/usecases/city/get_favorite_cities.dart';
import 'package:flutter_weather_app/domain/usecases/city/get_main_city.dart';
import 'package:flutter_weather_app/domain/usecases/city/set_main_city.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_weather_by_city.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_weather_favorite_cities.dart';
import 'package:get_it/get_it.dart';

import 'domain/usecases/weather/get_five_days_weather.dart';
import 'domain/usecases/weather/get_hourly_weather.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //____________________________________________________________________________
  //Use cases.
  //
  //Use cases weather.
  serviceLocator.registerLazySingleton(
      () => GetDailyWeather(weatherRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetHourlyWeather(weatherRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetWeatherByCity(weatherRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetFavoriteWeatherCities(weatherRepository: serviceLocator()));
  //
  //Use cases city.
  serviceLocator.registerLazySingleton(
      () => AddToFavoriteCity(cityRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetFavoriteCities(cityRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetMainCity(cityRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SetMainCity(cityRepository: serviceLocator()));
  //
  //Use cases api key.
  serviceLocator.registerLazySingleton(
      () => GetKeyFromEnv(apiKeyRepository: serviceLocator()));
  //____________________________________________________________________________
  //Repository
  //
  //Api key repository
  serviceLocator.registerLazySingleton<ApiKeyRepository>(
      () => ApiKeyRepositoryImpl(apiKeyLocalDatasource: serviceLocator()));
  //
  //City repository
  serviceLocator.registerLazySingleton<CityRepository>(
      () => CityRepositoryImpl(citiesLocalDatasource: serviceLocator()));
  //
  //Weather repository
  serviceLocator.registerLazySingleton<WeatherRepository>(() =>
      WeatherRepositoryImpl(
          apiKeyLocalDatasource: serviceLocator(),
          citiesLocalDatasource: serviceLocator(),
          weatherApiDatasource: serviceLocator()));
}
//______________________________________________________________________________