import 'dart:ffi';

import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/exception.dart';
import 'package:flutter_weather_app/data/data_source/local/sities_local_datasource.dart';
import 'package:flutter_weather_app/data/models/city_model.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/core/error/failure.dart';

import 'package:flutter_weather_app/domain/repositories/city_repo.dart';

class CityRepositoryImpl extends CityRepository {
  final CitiesLocalDatasource citiesLocalDatasource;

  CityRepositoryImpl({required this.citiesLocalDatasource});

  @override
  Future<Either<Failure, CityEntity>> getCurrentCity() async {
    return await _getCurrentCity();
  }

  @override
  Future<Either<Failure, List<String>>> getFavoriteCities() async {
    return await _getFavoriteCity();
  }

  @override
  Future<Either<Failure, void>> setCurrentCity(CityEntity city) async {
    return await _setCurrentCity(CityModel(cityName: city.cityName));
  }

  @override
  Future<Either<Failure, void>> setFavoriteCity(CityEntity city) async {
    return await _setFavoriteCity(CityModel(cityName: city.cityName));
  }

  Future<Either<Failure, CityModel>> _getCurrentCity() async {
    try {
      final city = await citiesLocalDatasource.getMainCity();
      return Right(city);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<String>>> _getFavoriteCity() async {
    try {
      final city = await citiesLocalDatasource.getFavorietesCities();
      return Right(city);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, void>> _setCurrentCity(CityModel city) async {
    try {
      await citiesLocalDatasource.setMainCity(city);
      return Right(Void);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, void>> _setFavoriteCity(CityModel city) async {
    try {
      await citiesLocalDatasource.addToFavoritiesCities(city);
      return Right(Void);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
