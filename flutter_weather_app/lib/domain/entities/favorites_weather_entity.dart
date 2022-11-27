import 'package:equatable/equatable.dart';

class FavoriteCitiesWeatherEntity extends Equatable {
  final double temp;
  final String status;
  final String description;

  const FavoriteCitiesWeatherEntity({
    required this.temp,
    required this.status,
    required this.description,
  });

  @override
  List<Object?> get props => [temp, status, description];
}
