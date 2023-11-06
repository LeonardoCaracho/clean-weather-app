class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '65a38cae31e6af2ae96678b1f38f0e4b';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
