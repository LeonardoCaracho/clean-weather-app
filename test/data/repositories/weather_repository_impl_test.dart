import 'dart:io';

import 'package:clean_weather_app/core/errors/exceptions.dart';
import 'package:clean_weather_app/core/errors/failures.dart';
import 'package:clean_weather_app/data/models/weather_model.dart';
import 'package:clean_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  group('get current weather', () {
    const testCityName = 'Rio';
    test(
      'should return current weather if a call to the data source is success',
      () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenAnswer(
          (_) async => testWeatherModel,
        );

        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);

        expect(result, equals(const Right(testWeatherEntity)));
      },
    );

    test(
      'should return server failure if a call to the data source is unsuccessful',
      () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(ServerException());

        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);

        expect(
            result,
            equals(const Left(
              ServerFailure('An error has ocurred'),
            )));
      },
    );

    test(
      'should return connection failure if a call to the data source is unsuccessful',
      () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(const SocketException(''));

        final result =
            await weatherRepositoryImpl.getCurrentWeather(testCityName);

        expect(
            result,
            equals(const Left(
              ConnectionFailure('Failed to connect to network'),
            )));
      },
    );
  });
}

const testWeatherModel = WeatherModel(
  cityName: 'Rio',
  main: 'Clouds',
  description: 'broken clouds',
  iconCode: '04n',
  temperature: 292.98,
  pressure: 1010,
  humidity: 74,
);

const testWeatherEntity = WeatherEntity(
  cityName: 'Rio',
  main: 'Clouds',
  description: 'broken clouds',
  iconCode: '04n',
  temperature: 292.98,
  pressure: 1010,
  umidity: 74,
);
