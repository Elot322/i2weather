import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';

//Class for work with Cities.
abstract class CityRepository {
  //Get/Set current city(Main city)
  Future<Either<Failure, CityEntity>> getCurrentCity();
  Future<Either<Failure, Right>> setCurrentCity(CityEntity city);

  //Get/Set favorietes cities(List cities on Main screen)
  Future<Either<Failure, List<String>>> getFavoriteCities();
  Future<Either<Failure, Right>> setFavoriteCity(CityEntity city);
}
