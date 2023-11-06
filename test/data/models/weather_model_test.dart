import 'dart:convert';

import 'package:clean_weather_app/data/models/weather_model.dart';
import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  var testWeatherModel = const WeatherModel(
    cityName: 'Rio',
    main: 'Clouds',
    description: 'broken clouds',
    iconCode: '04n',
    temperature: 292.98,
    pressure: 1010,
    humidity: 74,
  );

  test(
    'should be a subclass of weather entity',
    () {
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );

  group('toJson/fromJson', () {
    test('should return a valid model from json', () {
      final jsonMap = jsonDecode(
        readJson('helpers/dummy_data/dummy_weather_response.json'),
      );

      final result = WeatherModel.fromJson(jsonMap);

      expect(result, testWeatherModel);
    });

    test('should return a valid json map', () {
      final expectedJsonMap = {
        "weather": [
          {"main": "Clouds", "description": "broken clouds", "icon": "04n"}
        ],
        "main": {"temp": 292.98, "pressure": 1010, "humidity": 74},
        "name": "Rio",
      };

      final result = testWeatherModel.toJson();

      expect(result, expectedJsonMap);
    });
  });
}
