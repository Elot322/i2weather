import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/domain/entities/favorites_weather_entity.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object> get props => [];
}

class FavoriteEmpty extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();
  @override
  List<Object> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteCitiesWeatherEntity> listWeather;
  final List<String> listCities;
  const FavoriteLoaded({required this.listWeather, required this.listCities});
  @override
  List<Object> get props => [listWeather, listCities];
}

class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError({required this.message});
  @override
  List<Object> get props => [message];
}
