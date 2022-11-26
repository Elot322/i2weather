import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_state.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter_weather_app/sevice_locator.dart';

class PickCityScreen extends StatelessWidget {
  PickCityScreen({super.key});
  final TextEditingController cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PickCityCubit, PickState>(
      listener: (context, state) {
        if (state is ErrorPickState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_getSnackBar(state.message, Colors.red));
        } else if (state is HasDataPickState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_getSnackBar('Succes!', Colors.green));
        }
      },
      child: _pickerCity(context),
    );
  }

  Widget _pickerCity(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ENTER YOU CITY',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: cityNameController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<PickCityCubit>().setCity(
                      CityEntity(cityName: cityNameController.text),
                    );
                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    _navigateToWeatherPage(context);
                  },
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text(
                'NEXT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar _getSnackBar(String message, Color color) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: color,
    );
  }

  void _navigateToWeatherPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => WeatherCubit(
                      getMainCity: serviceLocator(),
                      getWeatherByCity: serviceLocator())
                    ..loadWeather(),
                  child: WeatherScreen(),
                )));
  }
}
