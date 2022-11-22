import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/domain/entities/api_key.dart';

abstract class ApiKeyRepository {
  Either<Failure, ApiKeyEntity> getKeyFromEnv();
}
