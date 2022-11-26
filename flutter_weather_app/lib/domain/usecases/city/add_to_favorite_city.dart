import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/repositories/city_repo.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';

class AddToFavoriteCity extends UseCase<void, CityParams> {
  final CityRepository cityRepository;

  AddToFavoriteCity({required this.cityRepository});

  @override
  Future<Either<Failure, void>> call(params, [String apiKey = '']) async {
    return await cityRepository.setFavoriteCity(CityEntity(
      cityName: params.cityName,
    ));
  }
}
