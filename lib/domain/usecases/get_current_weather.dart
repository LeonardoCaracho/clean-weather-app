import 'package:clean_weather_app/core/errors/failures.dart';
import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:clean_weather_app/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUsecase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUsecase({required this.weatherRepository});

  Future<Either<Failure, WeatherEntity>> execute(String city) {
    return weatherRepository.getCurrentWeather(city);
  }
}
