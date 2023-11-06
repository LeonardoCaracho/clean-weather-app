import 'package:clean_weather_app/core/constants/constants.dart';
import 'package:clean_weather_app/core/errors/exceptions.dart';
import 'package:clean_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:clean_weather_app/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherRemoteDataSource weatherRemoteDataSourceImpl;
  late MockHttpClient mockHttpClient;
  const testCityName = 'Rio';

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  test('should return WeatherModel if request is success', () async {
    when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityName))))
        .thenAnswer(
      (_) async => http.Response(
        readJson('helpers/dummy_data/dummy_weather_response.json'),
        200,
      ),
    );

    final result =
        await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

    expect(result, isA<WeatherModel>());
  });

  test('should return ServerExcpetion if request fails', () async {
    when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityName))))
        .thenAnswer(
      (_) async => http.Response(
        'Not found',
        404,
      ),
    );

    final result = weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

    expect(result, throwsA(isA<ServerException>()));
  });
}
