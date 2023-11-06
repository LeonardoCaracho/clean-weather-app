import 'dart:io';

import 'package:clean_weather_app/core/errors/exceptions.dart';
import 'package:clean_weather_app/core/errors/failures.dart';
import 'package:clean_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:clean_weather_app/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(city);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has ocurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to network'));
    }
  }
}
