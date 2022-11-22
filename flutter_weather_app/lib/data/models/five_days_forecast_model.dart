import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/daily_forecast_entity.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';

class FiveDaysForecastModel extends FiveDaysForecastEntity {
  const FiveDaysForecastModel(
      {required super.tempMax,
      required super.tempMin,
      required super.dateTime,
      required super.status,
      required super.description});

  factory FiveDaysForecastModel.fromJson(Map<String, dynamic> json) {
    var day = json['dt_txt'].split(' ')[0].split('-')[2];
    var mouth = json['dt_txt'].split(' ')[0].split('-')[1];
    var date = '$day-$mouth';

    return FiveDaysForecastModel(
      tempMax: json['main']['temp_max'],
      tempMin: json['main']['tempMin'],
      status: json['weather']['main'],
      description: json['weather']['description'],
      dateTime: date,
    );
  }

  @override
  List<Object?> get props => [dateTime];
}
