import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/repositories/city_repo.dart';

class GetFavoriteCities extends UseCase<List<String>, void> {
  final CityRepository cityRepository;

  GetFavoriteCities({required this.cityRepository});

  @override
  Future<Either<Failure, List<String>>> call(params,
      [String apiKey = '']) async {
    return await cityRepository.getFavoriteCities();
  }
}
