import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.umidity,
  });

  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int umidity;

  @override
  List<Object?> get props => [
        cityName,
        main,
        description,
        iconCode,
        temperature,
        pressure,
        umidity,
      ];
}
