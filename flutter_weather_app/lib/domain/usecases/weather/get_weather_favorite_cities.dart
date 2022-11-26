import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repo.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';

class GetFavoriteWeatherCities
    extends UseCase<FavoriteCitiesWeatherEntity, CityParams> {
  final WeatherRepository weatherRepository;

  GetFavoriteWeatherCities({required this.weatherRepository});

  @override
  Future<Either<Failure, FavoriteCitiesWeatherEntity>> call(CityParams params,
      [String apiKey = '']) async {
    return await weatherRepository.getFavoriteWeather(
        CityEntity(
          cityName: params.cityName,
        ),
        apiKey);
  }
}
