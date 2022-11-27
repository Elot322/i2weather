import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/presentation/bloc/favorite/favorite_weather_list_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/forecast/forecast_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/splash/splash_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/pages/splash_page.dart';
import 'package:flutter_weather_app/sevice_locator.dart';

class App extends StatelessWidget {
  const App({super.key});
  // This widget is the root of your application.
  //TODO: Make code review.
  //TODO:Make routes.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => serviceLocator<WeatherCubit>(),
        ),
        BlocProvider<PickCityCubit>(
          create: (context) => serviceLocator<PickCityCubit>(),
        ),
        BlocProvider<FavoriteCubit>(
            create: (context) =>
                serviceLocator<FavoriteCubit>()..loadFavoritiesCityWeather()),
        BlocProvider<ForecastCubit>(
            create: (context) => serviceLocator<ForecastCubit>()),
        BlocProvider<SplashCubit>(
            create: (context) =>
                serviceLocator<SplashCubit>()..mainCityChecker()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(), //TODO: Make theme data
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
