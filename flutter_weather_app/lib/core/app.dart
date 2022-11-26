import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/data_source/local/sities_local_datasource.dart';
import 'package:flutter_weather_app/presentation/bloc/favorite/favorite_weather_list_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/pages/pick_main_city_page.dart';
import 'package:flutter_weather_app/presentation/pages/splash_page.dart';
import 'package:flutter_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter_weather_app/sevice_locator.dart';

class App extends StatelessWidget {
  const App({super.key});
  // This widget is the root of your application.
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(), //TODO: Make theme data
        debugShowCheckedModeBanner: false,
        home: PickCityScreen(),
      ),
    );
  }
}
