import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';
import 'package:flutter_weather_app/domain/usecases/city/get_main_city.dart';
import 'package:flutter_weather_app/presentation/bloc/splash/splash_page_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetMainCity getMainCity;

  SplashCubit({required this.getMainCity}) : super(const SplashInitState());

  Future<void> mainCityChecker() async {
    // ignore: void_checks
    final city = await getMainCity.call(() {});

    city.fold((error) => emit(const NoDataState()),
        (data) => emit(HasMainCityState(city: data)));
  }
}
