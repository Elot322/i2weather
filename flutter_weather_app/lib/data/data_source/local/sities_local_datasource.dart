import 'package:flutter_weather_app/core/error/exception.dart';
import 'package:flutter_weather_app/data/models/city_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const CITIES_PREF = 'FAV_CITY';
// ignore: constant_identifier_names
const MAIN_PREF = 'MAIN_CITY';

abstract class CitiesLocalDatasource {
  Future<CityModel> getMainCity();
  Future setMainCity(CityModel city);
  Future<List<String>> getFavorietesCities();
  Future addToFavoritiesCities(CityModel city);
}

class CitiesLocalDatasourceImpl extends CitiesLocalDatasource {
  final SharedPreferences prefs;

  CitiesLocalDatasourceImpl({required this.prefs});

  @override
  Future<List<String>> getFavorietesCities() async {
    final cities = prefs.getStringList(CITIES_PREF) ?? [];
    return cities;
  }

  @override
  Future<CityModel> getMainCity() async {
    final mainCity = prefs.getString(MAIN_PREF);

    if (mainCity == null) {
      throw CacheException();
    } else {
      return CityModel(cityName: mainCity);
    }
  }

  @override
  Future<void> addToFavoritiesCities(CityModel city) async {
    List<String>? stringList = prefs.getStringList(CITIES_PREF);
    if (stringList == null) {
      stringList = [];
      stringList.add(city.cityName);
      await prefs.setStringList(CITIES_PREF, stringList);
    } else {
      stringList.add(city.cityName);
      await prefs.setStringList(CITIES_PREF, stringList);
    }
  }

  @override
  Future setMainCity(CityModel city) async {
    await prefs.setString(MAIN_PREF, city.cityName);
  }
}
