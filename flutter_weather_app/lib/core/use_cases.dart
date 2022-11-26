import 'package:either_dart/either.dart';
import 'package:flutter_weather_app/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params, [String apiKey = '']);
}
