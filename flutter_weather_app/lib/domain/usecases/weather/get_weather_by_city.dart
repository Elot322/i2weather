import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/entities/current_weather_entity.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repo.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';

class GetWeatherByCity extends UseCase<CurrentWeatherInCityEntity, CityParams> {
  final WeatherRepository weatherRepository;

  GetWeatherByCity({required this.weatherRepository});

  @override
  Future<Either<Failure, CurrentWeatherInCityEntity>> call(params,
      [String apiKey = '']) async {
    return await weatherRepository.getWeather(
        CityEntity(
          cityName: params.cityName,
        ),
        apiKey);
  }
}
