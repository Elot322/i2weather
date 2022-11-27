import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/usecases/city/city_params.dart';
import 'package:flutter_weather_app/domain/usecases/city/set_main_city.dart';
import 'package:flutter_weather_app/presentation/bloc/pick/pick_page_state.dart';

class PickCityCubit extends Cubit<PickState> {
  final SetMainCity setMainCity;

  PickCityCubit({required this.setMainCity}) : super(const InitPickState());

  Future<void> setCity(CityEntity entity) async {
    final cityData =
        await setMainCity.call(CityParams(cityName: entity.cityName));

    cityData.fold(
        (error) => emit(const ErrorPickState(message: 'Dont write local data')),
        (data) {
      emit(const HasDataPickState());
    });
  }
}
