import 'dart:convert';

import 'package:flutter_weather_app/core/error/exception.dart';
import 'package:flutter_weather_app/data/models/city_model.dart';
import 'package:flutter_weather_app/data/models/current_weather_model.dart';
import 'package:flutter_weather_app/data/models/favorites_weather_model.dart';
import 'package:flutter_weather_app/data/models/five_days_forecast_model.dart';
import 'package:flutter_weather_app/data/models/hourly_forecast_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherApiDatasource {
  //Call - http://api.openweathermap.org/data/2.5/weather?q={cityName}&units=metric&appid={apikey}
  //
  //Get current city weather
  Future<CurrentCityWeatherModel> getCurrentWeather(
    CityModel city,
    String apiKey,
  );

  //Call - http://api.openweathermap.org/data/2.5/forecast?q={cityName}&units=metric&appid={apiKey}
  //
  //Get 5 day city weather
  Future<Set<FiveDaysForecastModel>> getCurrentCityFiveDaysWeather(
    CityModel city,
    String apiKey,
  );

  //Call - http://api.openweathermap.org/data/2.5/weather?q={cityName}&units=metric&appid={apikey}
  //
  //Get favorities cities weather
  Future<FavoritiesCitiesWeatherModel> getFavoriteCityWeather(
    CityModel city,
    String apiKey,
  );

  //Call - http://api.openweathermap.org/data/2.5/weather?q={cityName}&cnt=8&units=metric&appid={apikey}
  //
  //Get 24h weather in city
  Future<List<HourlyForecastModel>> getCurrentCityHourlyWeather(
    CityModel city,
    String apiKey,
  );
}

class WeatherApiDatasourceImpl extends WeatherApiDatasource {
  final http.Client client;
  final String baseUrl = "http://api.openweathermap.org/data/2.5";

  WeatherApiDatasourceImpl({required this.client});

  @override
  Future<CurrentCityWeatherModel> getCurrentWeather(
      CityModel city, String apiKey) async {
    final String name = city.cityName;
    Uri url = Uri.parse("$baseUrl/weather?q=$name&units=metric&appid=$apiKey");

    final response = await client.get(
      url,
      headers: {"Contet-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final currentWeather = jsonDecode(response.body);
      return CurrentCityWeatherModel.fromJson(currentWeather);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Set<FiveDaysForecastModel>> getCurrentCityFiveDaysWeather(
      CityModel city, String apiKey) async {
    final String name = city.cityName;
    Uri url = Uri.parse("$baseUrl/forecast?q=$name&units=metric&appid=$apiKey");

    final response = await client.get(
      url,
      headers: {"Contet-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final fiveDaysWeather = jsonDecode(response.body);
      return (fiveDaysWeather['list'] as List)
          .map((fiveDaysWeather) =>
              FiveDaysForecastModel.fromJson(fiveDaysWeather))
          .toSet();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FavoritiesCitiesWeatherModel> getFavoriteCityWeather(
      CityModel city, String apiKey) async {
    final String name = city.cityName;
    Uri url = Uri.parse("$baseUrl/weather?q=$name&units=metric&appid=$apiKey");

    final response = await client.get(
      url,
      headers: {"Contet-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final favoritetWeather = jsonDecode(response.body);
      return FavoritiesCitiesWeatherModel.fromJson(favoritetWeather);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<HourlyForecastModel>> getCurrentCityHourlyWeather(
      CityModel city, String apiKey) async {
    final String name = city.cityName;
    Uri url =
        Uri.parse("$baseUrl/forecast?q=$name&units=metric&cnt=8&appid=$apiKey");

    final response = await client.get(
      url,
      headers: {"Contet-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final hourlyForecastWeather = jsonDecode(response.body);
      return (hourlyForecastWeather['list'] as List)
          .map((hourlyForecastWeather) =>
              HourlyForecastModel.fromJson(hourlyForecastWeather))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
