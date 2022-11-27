import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_five_days_weather.dart';
import 'package:flutter_weather_app/domain/usecases/weather/get_hourly_weather.dart';
import 'package:flutter_weather_app/presentation/bloc/forecast/forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final GetHourlyWeather getHourlyWeather;
  final GetDailyWeather getDailyWeather;

  ForecastCubit({required this.getHourlyWeather, required this.getDailyWeather})
      : super(const ForecastEmpty());

  Future<void> getHourlyForecastWeather(CityEntity city) async {
    emit(const ForecastLoading());
    const apiKey = String.fromEnvironment('API_KEY');
    final data = await getHourlyWeather.call(
        CityParams(cityName: city.cityName), apiKey);
    data.fold(
        (error) => emit(const ForecastError(
            message: 'Hourly forecast weather has no data')),
        (weather) => emit(HourlyForecastStateLoaded(hourlyList: weather)));
  }

  Future<void> getDailyForecastWeather(CityEntity city) async {
    emit(const ForecastLoading());
    const apiKey = String.fromEnvironment('API_KEY');
    final data =
        await getDailyWeather.call(CityParams(cityName: city.cityName), apiKey);
    data.fold(
        (error) => emit(const ForecastError(
            message: 'Hourly forecast weather has no data')),
        (weather) => emit(DailyForecastStateLoaded(dailyList: weather)));
  }
}
