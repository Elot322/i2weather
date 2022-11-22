import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/weather.dart';

class FiveDaysForecastEntity extends Equatable {
  final double tempMin;
  final double tempMax;
  final String dateTime;
  final String status;
  final String description;

  const FiveDaysForecastEntity(
      {required this.tempMax,
      required this.tempMin,
      required this.dateTime,
      required this.status,
      required this.description});

  @override
  List<Object?> get props => [dateTime];
}
