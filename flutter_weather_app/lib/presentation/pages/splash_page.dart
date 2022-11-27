import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/presentation/bloc/forecast/forecast_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/splash/splash_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/splash/splash_page_state.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/pages/pick_main_city_page.dart';
import 'package:flutter_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter_weather_app/sevice_locator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is HasMainCityState) {
          Future.delayed(const Duration(seconds: 3), () {
            _navigateToWeatherPage(context, state.city.cityName);
          });
        } else if (state is NoDataState) {
          Future.delayed(const Duration(seconds: 3), () {
            _navigateToPickPage(context);
          });
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.sunny,
                size: 50,
                color: Colors.orange,
              ),
              Text(
                'I2WEATHER',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToWeatherPage(BuildContext context, String cityName) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => WeatherCubit(
                          getMainCity: serviceLocator(),
                          getWeatherByCity: serviceLocator())
                        ..loadWeather(),
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
                ))));
  }

  void _navigateToPickPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (context) =>
                      PickCityCubit(setMainCity: serviceLocator()),
                  child: PickCityScreen(),
                ))));
  }
}
