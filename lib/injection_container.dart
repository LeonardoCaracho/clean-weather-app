import 'package:clean_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:clean_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:clean_weather_app/domain/repositories/weather_repository.dart';
import 'package:clean_weather_app/domain/usecases/get_current_weather.dart';
import 'package:clean_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(
      () => GetCurrentWeatherUsecase(weatherRepository: locator()));

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
