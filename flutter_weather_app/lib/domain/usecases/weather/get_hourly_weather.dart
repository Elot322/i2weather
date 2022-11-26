import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/entities/hourly_forecast_entity.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repo.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';

class GetHourlyWeather extends UseCase<List<HourlyForecastEntity>, CityParams> {
  final WeatherRepository weatherRepository;

  GetHourlyWeather({required this.weatherRepository});

  @override
  Future<Either<Failure, List<HourlyForecastEntity>>> call(params,
      [String apiKey = '']) async {
    return await weatherRepository.getHourlyForecast(
        CityEntity(
          cityName: params.cityName,
        ),
        apiKey);
  }
}
