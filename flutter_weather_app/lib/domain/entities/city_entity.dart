import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String cityName;

  const CityEntity({
    required this.cityName,
  });

  @override
  List<Object?> get props => [
        cityName,
      ];
}
