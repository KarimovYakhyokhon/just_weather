import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_weather/models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    // api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}
    // api.openweathermap.org/data/2.5/forecast/daily?q=london&units=metric&APPID=value&cnt=7

    final queryParameters = {
      'q': city,
      'units': 'imperial',
      'appid': 'eb62a4650e912bf8a8bce1416d2b3900',
      'ctn': '7'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
