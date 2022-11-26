import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/error/failure.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';
import 'package:flutter_weather_app/domain/usecases/city/add_to_favorite_city.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';
import 'package:flutter_weather_app/domain/usecases/city/get_favorite_cities.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_weather_favorite_cities.dart';
import 'package:flutter_weather_app/presentation/bloc/favorite/favorite_weather_list_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoriteCities getFavoriteCities;
  final GetFavoriteWeatherCities getFavoriteWeatherCities;
  final AddToFavoriteCity addToFavoriteCity;

  FavoriteCubit({
    required this.getFavoriteCities,
    required this.getFavoriteWeatherCities,
    required this.addToFavoriteCity,
  }) : super(FavoriteEmpty());

  Future<void> loadFavoritiesCityWeather() async {
    const apiKey = String.fromEnvironment('API_KEY');
    final List<FavoriteCitiesWeatherEntity> listWeather = [];
    final cities = await getFavoriteCities.call(() {});
    cities.fold(
        (error) => emit(FavoriteError(message: _mapFailureToMessage(error))),
        (cities) async {
      if (cities != []) {
        for (String city in cities) {
          final weather = await getFavoriteWeatherCities.call(
              CityParams(cityName: city), apiKey);
          weather.fold(
              (error) =>
                  emit(FavoriteError(message: _mapFailureToMessage(error))),
              (data) => {listWeather.add(data)});
        }
        emit(FavoriteLoaded(listWeather: listWeather, listCities: cities));
      } else {
        emit(FavoriteEmpty());
      }
    });
  }

  Future<void> addCityToFavorite(CityEntity cityEntity) async {
    final setCity =
        await addToFavoriteCity.call(CityParams(cityName: cityEntity.cityName));
    setCity.fold(
        (error) => emit(FavoriteError(message: _mapFailureToMessage(error))),
        (data) async {
      await loadFavoritiesCityWeather();
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
