import 'package:bloc_test/bloc_test.dart';
import 'package:clean_weather_app/core/errors/failures.dart';
import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:clean_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:clean_weather_app/presentation/bloc/weather_event.dart';
import 'package:clean_weather_app/presentation/bloc/weather_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase;
  late WeatherBloc weatherBloc;
  const testCityName = 'Rio';

  setUp(() {
    mockGetCurrentWeatherUsecase = MockGetCurrentWeatherUsecase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUsecase);
  });

  test('initial state should be empty', () {
    expect(weatherBloc.state, isA<WeatherEmpty>());
  });

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 320.21,
    pressure: 1009,
    umidity: 70,
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherSuccess] if the data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUsecase.execute(testCityName)).thenAnswer(
        (_) async => const Right(testWeatherEntity),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => <WeatherState>[
      WeatherLoading(),
      const WeatherLoaded(testWeatherEntity)
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailue] if the data is gotten unsuccessfully',
    build: () {
      when(mockGetCurrentWeatherUsecase.execute(testCityName)).thenAnswer(
        (_) async => const Left(ServerFailure('An error has ocurred')),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => <WeatherState>[
      WeatherLoading(),
      const WeatherLoadFailue('An error has ocurred')
    ],
  );
}
