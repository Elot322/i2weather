import 'package:flutter_weather_app/core/error/exception.dart';
import 'package:flutter_weather_app/data/models/api_key_model.dart';

abstract class ApiKeyLocalDatasource {
  // Get from --dart-define {apiKey}
  //
  //Get Api Key From ENV
  ApiKeyModel getApiKeyFromEnv();
}

class ApiKeyLocalDatasourceImpl extends ApiKeyLocalDatasource {
  @override
  ApiKeyModel getApiKeyFromEnv() {
    var apiKey = String.fromEnvironment('API_KEY');
    if (apiKey.isEmpty) {
      throw CacheException();
    }
    return ApiKeyModel(apiKey: apiKey);
  }
}
