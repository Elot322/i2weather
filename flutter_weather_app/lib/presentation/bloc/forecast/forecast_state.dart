import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/daily_forecast_entity.dart';
import 'package:flutter_weather_app/domain/entities/hourly_forecast_entity.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();

  @override
  List<Object> get props => [];
}

class ForecastEmpty extends ForecastState {
  const ForecastEmpty();

  @override
  List<Object> get props => [];
}

class HourlyForecastStateLoaded extends ForecastState {
  final List<HourlyForecastEntity> hourlyList;
  const HourlyForecastStateLoaded({required this.hourlyList});

  @override
  List<Object> get props => [hourlyList];
}

class DailyForecastStateLoaded extends ForecastState {
  final Set<FiveDaysForecastEntity> dailyList;
  const DailyForecastStateLoaded({required this.dailyList});

  @override
  List<Object> get props => [dailyList];
}

class ForecastLoading extends ForecastState {
  const ForecastLoading();

  @override
  List<Object> get props => [];
}

class ForecastError extends ForecastState {
  final String message;
  const ForecastError({required this.message});

  @override
  List<Object> get props => [];
}
