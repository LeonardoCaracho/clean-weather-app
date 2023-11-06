import 'package:clean_weather_app/core/errors/failures.dart';
import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}
