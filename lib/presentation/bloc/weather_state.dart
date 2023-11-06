import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class WeatherLoadFailue extends WeatherState {
  final String message;

  const WeatherLoadFailue(this.message);

  @override
  List<Object?> get props => [message];
}
