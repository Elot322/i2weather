import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/city_entity.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitState extends SplashState {
  const SplashInitState();

  @override
  List<Object> get props => [];
}

class HasMainCityState extends SplashState {
  final CityEntity city;
  const HasMainCityState({required this.city});

  @override
  List<Object> get props => [];
}

class NoDataState extends SplashState {
  const NoDataState();

  @override
  List<Object> get props => [];
}
