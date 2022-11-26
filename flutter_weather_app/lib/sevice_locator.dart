import 'package:flutter_weather_app/data/data_source/api/weather_api_datasource.dart';
import 'package:flutter_weather_app/data/data_source/local/sities_local_datasource.dart';
import 'package:flutter_weather_app/data/repositories/cities_repo_impl.dart';
import 'package:flutter_weather_app/data/repositories/weather_repo_impl.dart';
import 'package:flutter_weather_app/domain/repositories/city_repo.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repo.dart';
import 'package:flutter_weather_app/domain/usecases/city/add_to_favorite_city.dart';
import 'package:flutter_weather_app/domain/usecases/city/get_favorite_cities.dart';
import 'package:flutter_weather_app/domain/usecases/city/get_main_city.dart';
import 'package:flutter_weather_app/domain/usecases/city/set_main_city.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_weather_by_city.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_weather_favorite_cities.dart';
import 'package:flutter_weather_app/presentation/bloc/favorite/favorite_weather_list_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_weather_app/domain/usecases/weather/get_five_days_weather.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_hourly_weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Factory
  //
  //Cubits
  serviceLocator.registerFactory(
    () => WeatherCubit(
      getWeatherByCity: serviceLocator(),
      getMainCity: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => PickCityCubit(
      setMainCity: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FavoriteCubit(
      getFavoriteCities: serviceLocator(),
      getFavoriteWeatherCities: serviceLocator(),
      addToFavoriteCity: serviceLocator(),
    ),
  );

  //____________________________________________________________________________
  //Use cases.
  //
  //Use cases weather.
  serviceLocator.registerLazySingleton(() => GetDailyWeather(
        weatherRepository: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => GetHourlyWeather(
        weatherRepository: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => GetWeatherByCity(
        weatherRepository: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => GetFavoriteWeatherCities(
        weatherRepository: serviceLocator(),
      ));
  //
  //Use cases city.
  serviceLocator.registerLazySingleton(() => AddToFavoriteCity(
        cityRepository: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => GetFavoriteCities(
        cityRepository: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => GetMainCity(
        cityRepository: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => SetMainCity(
        cityRepository: serviceLocator(),
      ));

  //____________________________________________________________________________
  //Repository
  //
  //City repository
  serviceLocator.registerLazySingleton<CityRepository>(() => CityRepositoryImpl(
        citiesLocalDatasource: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton<CitiesLocalDatasource>(
      () => CitiesLocalDatasourceImpl(prefs: serviceLocator()));
  //
  //Weather repository
  serviceLocator
      .registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
            citiesLocalDatasource: serviceLocator(),
            weatherApiDatasource: serviceLocator(),
          ));
  serviceLocator.registerLazySingleton<WeatherApiDatasource>(
      () => WeatherApiDatasourceImpl(
            client: serviceLocator(),
          ));

  final preferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => preferences);
  serviceLocator.registerLazySingleton(() => http.Client());
}
//______________________________________________________________________________