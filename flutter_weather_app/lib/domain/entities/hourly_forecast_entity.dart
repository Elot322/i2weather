import 'package:equatable/equatable.dart';

class HourlyForecastEntity extends Equatable {
  final double temp;
  final String time;

  const HourlyForecastEntity({required this.temp, required this.time});

  @override
  List<Object?> get props => [
        temp,
        time,
      ];
}
