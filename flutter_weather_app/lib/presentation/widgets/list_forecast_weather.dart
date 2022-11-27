import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/daily_forecast_entity.dart';
import 'package:flutter_weather_app/domain/entities/hourly_forecast_entity.dart';
import 'package:flutter_weather_app/presentation/bloc/forecast/forecast_state.dart';
import 'package:flutter_weather_app/presentation/bloc/forecast/forecast_cubit.dart';

class ListPeriodWeather extends StatelessWidget {
  const ListPeriodWeather({super.key});

  @override
  Widget build(BuildContext context) {
    int length;
    Set<FiveDaysForecastEntity> listDaily;
    List<HourlyForecastEntity> listHourly = [];

    return SizedBox(
      height: 300,
      child: BlocBuilder<ForecastCubit, ForecastState>(
        builder: (context, state) {
          if (state is DailyForecastStateLoaded) {
            listDaily = state.dailyList;
            length = listDaily.length;
            return ListView.builder(
              itemCount: length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _buildDailyTileInfo(listDaily.elementAt(index));
              },
            );
          } else if (state is HourlyForecastStateLoaded) {
            listHourly = state.hourlyList;
            length = listHourly.length;
            return ListView.builder(
              itemCount: length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _buildHourlyTileInfo(listHourly[index]);
              },
            );
          } else if (state is ForecastLoading) {
            return _loadingIndicator();
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildDailyTileInfo(FiveDaysForecastEntity daily) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(120, 6, 6, 7),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Date: ${daily.dateTime}: ${daily.tempMax}/${daily.tempMin}°C',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              '${daily.status}: ${daily.description}',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyTileInfo(HourlyForecastEntity hourly) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(120, 6, 6, 7),
      ),
      child: Center(
        child: Text(
          'Time: ${hourly.time} Temp: ${hourly.temp}°C',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
