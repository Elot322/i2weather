import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/repositories/city_repo.dart';

class GetMainCity extends UseCase<CityEntity, void> {
  final CityRepository cityRepository;

  GetMainCity({required this.cityRepository});

  @override
  Future<Either<Failure, CityEntity>> call(params) async {
    return await cityRepository.getCurrentCity();
  }
}
