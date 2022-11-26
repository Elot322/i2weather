import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';
import 'package:flutter_weather_app/presentation/bloc/favorite/favorite_weather_list_cubit.dart';
import 'package:flutter_weather_app/presentation/bloc/favorite/favorite_weather_list_state.dart';
import 'package:flutter_weather_app/presentation/bloc/weather/weather_city_cubit.dart';
import 'package:flutter_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter_weather_app/presentation/widgets/add_favorite_city_dialog.dart';
import 'package:flutter_weather_app/sevice_locator.dart';

class ListFavoritiesWeather extends StatelessWidget {
  final items = 1;

  const ListFavoritiesWeather({super.key});

  @override
  Widget build(BuildContext context) {
    List<FavoriteCitiesWeatherEntity> weather = [];
    List<String> city = [];

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoaded) {
          weather = state.listWeather;
          city = state.listCities;
        } else if (state is FavoriteLoading) {
          return _loadingIndicator();
        }
        return ListView.builder(
          itemCount: city.length + 1,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int ind) {
            if (ind == city.length) {
              return SizedBox(
                height: 100,
                width: 130,
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(120, 6, 6, 7),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ADD',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AddCityFavoriteDialog();
                              });
                        },
                      ),
                      const Text(
                        'CITY',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return _buildTile(city[ind], weather[ind], context);
            }
          },
        );
      },
    );
  }

  Widget _buildTile(
    String cityName,
    FavoriteCitiesWeatherEntity weather,
    BuildContext context,
  ) {
    return SizedBox(
      height: 100,
      width: 130,
      child: InkWell(
        onTap: () {
          _navigateToWeatherPage(context, cityName);
        },
        onLongPress: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: Text('DELETE $cityName?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'YES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'NO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              }));
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(120, 6, 6, 7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                cityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${weather.temp}°C',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                weather.status,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                weather.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
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

  void _navigateToWeatherPage(BuildContext context, String city) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => WeatherCubit(
                      getMainCity: serviceLocator(),
                      getWeatherByCity: serviceLocator())
                    ..loadWeatherByCity(city),
                  child: WeatherScreen(),
                )));
  }
}
