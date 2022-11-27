import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather/weather_city_cubit.dart';
import '../bloc/weather/weather_city_state.dart';

class CityDetailRow extends StatelessWidget {
  const CityDetailRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoaded) {
          return _infoRaw(
            state.weather.currentTemp,
            state.weather.feelsLikeTemp,
            state.weather.windSpeed,
            state.weather.cloudsPercentage,
          );
        }
        return _infoRaw(0, 0, 0, 0);
      },
    );
  }

  Widget _infoRaw(double temp, feelsLikeTemp, windSpeed, int cloudPercentage) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(120, 6, 6, 7),
            ),
            child: Column(children: [
              const Text(
                'TEMP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.thermostat,
                color: Colors.white,
                size: 60,
              ),
              Text(
                '$temp°C',
                style: const TextStyle(color: Colors.white),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(120, 6, 6, 7),
            ),
            child: Column(
              children: [
                const Text(
                  'FEELS LIKE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
                Text(
                  '$feelsLikeTemp°C',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(120, 6, 6, 7),
            ),
            child: Column(
              children: [
                const Text(
                  'CLOUDS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.cloud,
                  color: Colors.white,
                  size: 60,
                ),
                Text(
                  '$cloudPercentage%',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(120, 6, 6, 7),
            ),
            child: Column(
              children: [
                const Text(
                  'WIND SPEED',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.wind_power,
                  color: Colors.white,
                  size: 60,
                ),
                Text(
                  '${windSpeed}m/s',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
