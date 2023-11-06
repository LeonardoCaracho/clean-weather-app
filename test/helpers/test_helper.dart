import 'package:clean_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:clean_weather_app/domain/repositories/weather_repository.dart';
import 'package:clean_weather_app/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUsecase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
