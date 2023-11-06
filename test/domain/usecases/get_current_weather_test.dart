import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:clean_weather_app/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUsecase = GetCurrentWeatherUsecase(
      weatherRepository: mockWeatherRepository,
    );
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 320.21,
    pressure: 1009,
    umidity: 70,
  );

  const testCityName = 'New York';

  test('should get current weather from repository', () async {
    when(mockWeatherRepository.getCurrentWeather(testCityName)).thenAnswer(
      (_) async => const Right(testWeatherDetail),
    );

    final result = await getCurrentWeatherUsecase.execute(testCityName);

    expect(result, const Right(testWeatherDetail));
  });
}
