import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/presentation/bloc/forecast/forecast_cubit.dart';

class ChangePeriodMenu extends StatelessWidget {
  static const menuItems = <String>['24 hour', '5 days'];
  final String cityName;

  const ChangePeriodMenu({super.key, required this.cityName});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        onSelected: ((value) {
          if (value == '0') {
            context
                .read<ForecastCubit>()
                .getHourlyForecastWeather(CityEntity(cityName: cityName));
          } else {
            context
                .read<ForecastCubit>()
                .getDailyForecastWeather(CityEntity(cityName: cityName));
          }
        }),
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem(
              value: '0',
              child: Text("24 hour"),
            ),
            PopupMenuItem(
              value: '1',
              child: Text("5 days"),
            ),
          ];
        });
  }
}
