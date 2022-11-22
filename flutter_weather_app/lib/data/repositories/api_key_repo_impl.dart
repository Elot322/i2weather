import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/exception.dart';
import 'package:flutter_weather_app/data/data_source/local/api_key_local_datasource.dart';
import 'package:flutter_weather_app/data/models/api_key_model.dart';
import 'package:flutter_weather_app/domain/entities/api_key.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/domain/repositories/api_key_repo.dart';

class ApiKeyRepositoryImpl extends ApiKeyRepository {
  final ApiKeyLocalDatasource apiKeyLocalDatasource;

  ApiKeyRepositoryImpl({required this.apiKeyLocalDatasource});

  @override
  Either<Failure, ApiKeyEntity> getKeyFromEnv() {
    return _getApiKey();
  }

  Either<Failure, ApiKeyModel> _getApiKey() {
    try {
      final apikey = apiKeyLocalDatasource.getApiKeyFromEnv();
      return Right(apikey);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
