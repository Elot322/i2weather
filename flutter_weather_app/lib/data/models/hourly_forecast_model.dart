import 'package:flutter_weather_app/domain/entities/hourly_forecast_entity.dart';

class HourlyForecastModel extends HourlyForecastEntity {
  const HourlyForecastModel({required super.temp, required super.time});

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) {
    var hour = json['dt_txt'].split(' ')[1].split(':')[0];
    var min = json['dt_txt'].split(' ')[1].split(':')[1];
    var time = '$hour:$min';
    return HourlyForecastModel(
      temp: json['main']['temp'],
      time: time,
    );
  }
}
