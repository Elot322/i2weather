import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/core/use_cases.dart';
import 'package:flutter_weather_app/domain/entities/api_key.dart';
import 'package:flutter_weather_app/domain/repositories/api_key_repo.dart';

class GetKeyFromEnv extends UseCase<ApiKeyEntity, void> {
  final ApiKeyRepository apiKeyRepository;

  GetKeyFromEnv({required this.apiKeyRepository});

  @override
  Future<Either<Failure, ApiKeyEntity>> call(params) async {
    return apiKeyRepository.getKeyFromEnv();
  }
}
