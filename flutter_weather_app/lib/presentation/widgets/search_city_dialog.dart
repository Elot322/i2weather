import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/presentation/bloc/forecast/forecast_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter_weather_app/sevice_locator.dart';

class SearchCityDialog extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchCityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'SEARCH CITY WEATHER',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      content: TextField(
        controller: searchController,
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            _navigateToSearchedCity(context, searchController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'SEARCH',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'CANCEL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToSearchedCity(BuildContext context, String cityName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => WeatherCubit(
                          getMainCity: serviceLocator(),
                          getWeatherByCity: serviceLocator())
                        ..loadWeatherByCity(cityName),
                    ),
                    BlocProvider(
                      create: (context) => ForecastCubit(
                          getHourlyWeather: serviceLocator(),
                          getDailyWeather: serviceLocator())
                        ..getHourlyForecastWeather(
                            CityEntity(cityName: cityName)),
                    ),
                  ],
                  child: const WeatherScreen(),
                )));
  }
}
