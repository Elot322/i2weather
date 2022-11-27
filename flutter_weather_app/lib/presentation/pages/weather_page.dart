import 'package:flutter/material.dart';
import 'package:flutter_weather_app/presentation/widgets/city_detail_weather_row.dart';
import 'package:flutter_weather_app/presentation/widgets/city_weather_container.dart';
import 'package:flutter_weather_app/presentation/widgets/list_favorities_weather.dart';
import 'package:flutter_weather_app/presentation/widgets/list_forecast_weather.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 6, 6, 7),
        shadowColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(100, 44, 44, 45),
      body: SingleChildScrollView(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CityWeatherContainer(),
              Divider(
                color: Colors.black,
              ),
              CityDetailRow(),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 100,
                child: ListFavoritiesWeather(),
              ),
              Divider(
                color: Colors.black,
              ),
              ListPeriodWeather(),
            ],
          ),
        ),
      ),
    );
  }
}
