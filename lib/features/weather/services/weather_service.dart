import 'dart:convert';

import 'package:weather/features/weather/domain/uv_data.dart';
import 'package:weather/features/weather/domain/weather.dart';

import 'package:http/http.dart' as http;

class WeatherService {
  Future<WeatherData> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=56.946528704775936&lon=24.2475472319737&appid=e8e5f6f91a238065d8ba0123f65e95d5&units=metric'));

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<UVData> fetchUvData() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/uvi?lat=56.946528704775936&lon=24.2475472319737&appid=e8e5f6f91a238065d8ba0123f65e95d5'));

    if (response.statusCode == 200) {
      return UVData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load uv data');
    }
  }
}
