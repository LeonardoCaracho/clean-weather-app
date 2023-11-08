import 'dart:io';

import 'package:clean_weather_app/domain/entities/weather.dart';
import 'package:clean_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:clean_weather_app/presentation/bloc/weather_event.dart';
import 'package:clean_weather_app/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:clean_weather_app/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 320.21,
    pressure: 1009,
    umidity: 70,
  );

  testWidgets(
    'text field should trigger state to change from empty to loading',
    (widgetTester) async {
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'Rio');
      await widgetTester.pump();
      expect(find.text('Rio'), findsOneWidget);
    },
  );

  testWidgets('should show progress indicator when state is loading',
      (widgetTester) async {
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should show widget contain weather data when state is weather loaded',
      (widgetTester) async {
    when(() => mockWeatherBloc.state)
        .thenReturn(const WeatherLoaded(testWeatherEntity));

    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
    await widgetTester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const Key('weather_data')), findsOneWidget);
  });
}
