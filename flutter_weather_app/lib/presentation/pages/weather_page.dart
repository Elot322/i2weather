import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_state.dart';
import 'package:flutter_weather_app/presentation/widgets/city_detail_weather_row.dart';
import 'package:flutter_weather_app/presentation/widgets/city_weather_container.dart';
import 'package:flutter_weather_app/presentation/widgets/list_favorities_weather.dart';
import 'package:flutter_weather_app/presentation/widgets/list_five_days_weather.dart';
import 'package:flutter_weather_app/presentation/widgets/list_hourly_weather.dart';
import 'package:flutter_weather_app/presentation/widgets/popup_menu.dart';
import 'package:flutter_weather_app/presentation/widgets/search_city_dialog.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(150, 6, 6, 7),
        shadowColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(100, 44, 44, 45),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CityWeatherContainer(),
              const Divider(
                color: Colors.black,
              ),
              CityDetailRow(),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 100,
                child: ListFavoritiesWeather(),
              ),
              const Divider(
                color: Colors.black,
              ),
              ListFiveDaysWeather(),
            ],
          ),
        ),
      ),
    );
  }
}
