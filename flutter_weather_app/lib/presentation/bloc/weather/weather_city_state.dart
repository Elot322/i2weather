import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/current_weather_entity.dart';
import 'package:flutter_weather_app/domain/entities/daily_forecast_entity.dart';
import 'package:flutter_weather_app/domain/entities/hourly_forecast_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {
  const WeatherEmpty();
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final CurrentWeatherInCityEntity weather;
  final String cityName;

  const WeatherLoaded({
    required this.weather,
    required this.cityName,
  });

  @override
  List<Object> get props => [
        weather,
      ];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchedWeatherError extends WeatherState {
  final String message;

  const SearchedWeatherError({required this.message});

  @override
  List<Object> get props => [message];
}

class WeatherForecastDailyState extends WeatherState {
  final List<FiveDaysForecastEntity> listFiveDays;

  const WeatherForecastDailyState({required this.listFiveDays});
  @override
  List<Object> get props => [listFiveDays];
}

class WeatherForecastHourlyState extends WeatherState {
  final List<HourlyForecastEntity> listHourly;

  const WeatherForecastHourlyState({required this.listHourly});
  @override
  List<Object> get props => [listHourly];
}
