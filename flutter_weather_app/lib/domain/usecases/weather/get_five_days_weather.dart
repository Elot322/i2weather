import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/entities/daily_forecast_entity.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repo.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';

class GetDailyWeather extends UseCase<Set<FiveDaysForecastEntity>, CityParams> {
  final WeatherRepository weatherRepository;

  GetDailyWeather({required this.weatherRepository});

  @override
  Future<Either<Failure, Set<FiveDaysForecastEntity>>> call(params) async {
    return await weatherRepository.getDailyForecast(CityEntity(
      cityName: params.cityName,
    ));
  }
}
