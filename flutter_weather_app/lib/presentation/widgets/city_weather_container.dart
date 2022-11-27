import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_state.dart';
import 'package:flutter_weather_app/presentation/pages/pick_main_city_page.dart';
import 'package:flutter_weather_app/presentation/widgets/popup_menu.dart';
import 'package:flutter_weather_app/presentation/widgets/search_city_dialog.dart';
import 'package:flutter_weather_app/sevice_locator.dart';

class CityWeatherContainer extends StatelessWidget {
  const CityWeatherContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return _loadingIndicator();
        } else if (state is WeatherLoaded) {
          return _cityContainer(
            context,
            state.cityName,
            state.weather.status,
            state.weather.description,
            Icon(_iconPicker(state.weather.status)),
          );
        }
        return _emptyContainer(context);
      },
      listener: (context, state) {
        if (state is WeatherError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_getSnackBar(state.message, Colors.red));
          _navigateToPickPage(context);
        }
        if (state is SearchedWeatherError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(_getSnackBar('Error! City not found.', Colors.red));
        }
      },
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

  Widget _emptyContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(120, 6, 6, 7),
      ),
      child: Column(
        children: const [
          Text(
            'Weather in this city not found',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            'Pick correct city',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            'Redirect...',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _cityContainer(
      BuildContext context, String cityName, status, description, Icon icon) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(
        top: 35,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(120, 6, 6, 7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cityName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return SearchCityDialog();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ],
          ),
          Icon(
            icon.icon,
            color: Colors.white,
            size: 60,
          ),
          Text(
            status,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            description,
            style: const TextStyle(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ChangePeriodMenu(
                cityName: cityName,
              ),
            ],
          ),
        ],
      ),
    );
  }

  SnackBar _getSnackBar(String message, Color color) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      backgroundColor: color,
    );
  }

  void _navigateToPickPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      PickCityCubit(setMainCity: serviceLocator()),
                  child: PickCityScreen(),
                )));
  }

  //TODO: MAKE REPOSITTORY ICONS FROM -  http://openweathermap.org/img/wn/
  IconData _iconPicker(String status) {
    if (status == 'Clouds') {
      return Icons.cloud;
    } else if (status == 'Snow') {
      return Icons.cloudy_snowing;
    } else if (status == 'Rain') {
      return Icons.cloud;
    } else if (status == 'Drizzle') {
      return Icons.cloudy_snowing;
    } else {
      return Icons.sunny;
    }
  }
}
