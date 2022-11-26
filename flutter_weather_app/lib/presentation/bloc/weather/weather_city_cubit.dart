import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/error/failure.dart';

import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';
import 'package:flutter_weather_app/domain/usecases/city/get_main_city.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_weather_by_city.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherByCity getWeatherByCity;
  final GetMainCity getMainCity;
  final apiKey = const String.fromEnvironment('API_KEY');

  WeatherCubit({required this.getWeatherByCity, required this.getMainCity})
      : super(WeatherEmpty());

  Future<void> loadWeather() async {
    emit(const WeatherLoading());
    final failureOrCity = await getMainCity.call(() {});
    print(failureOrCity);
    print(apiKey);

    failureOrCity.fold(
        (error) => emit(WeatherError(message: _mapFailureToMessage(error))),
        (city) async {
      final data = await getWeatherByCity.call(
          CityParams(cityName: city.cityName), apiKey);
      data.fold(
          (error) => emit(WeatherError(message: _mapFailureToMessage(error))),
          (weather) {
        emit(WeatherLoaded(weather: weather, cityName: city.cityName));
      });
    });
  }

  Future<void> loadWeatherByCity(String city) async {
    emit(const WeatherLoading());
    final data =
        await getWeatherByCity.call(CityParams(cityName: city), apiKey);
    data.fold(
        (error) => emit(WeatherError(message: _mapFailureToMessage(error))),
        (weather) {
      emit(WeatherLoaded(weather: weather, cityName: city));
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
