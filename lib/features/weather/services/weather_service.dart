import 'dart:convert';

import 'package:weather/features/weather/domain/uv_data.dart';
import 'package:weather/features/weather/domain/weather.dart';

import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class WeatherService {
  Future<WeatherData> fetchWeatherDataForLocation({
    required String latitude,
    required String longitude,
  }) async {
    print(
        'fetchWeatherDataForLocation: latitude: $latitude / longitude: $longitude');
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=e8e5f6f91a238065d8ba0123f65e95d5&units=metric'));

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<UVData> fetchUvDataForLocation({
    required String latitude,
    required String longitude,
  }) async {
    print(
        'fetchUvDataForLocation: latitude: $latitude / longitude: $longitude');
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/uvi?lat=$latitude&lon=$longitude&appid=e8e5f6f91a238065d8ba0123f65e95d5'));

    if (response.statusCode == 200) {
      return UVData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load uv data');
    }
  }

  Future<UVData> fetchUvDataFor({required String city}) async {
    try {
      print('fetchUvDataFor: $city');
      List<Location> locations = await locationFromAddress(city);

      if (locations.isNotEmpty) {
        final location = locations.first;
        return await fetchUvDataForLocation(
          latitude: '${location.latitude}',
          longitude: '${location.longitude}',
        );
      } else {
        throw Exception('Failed to get coordinates for the provided city');
      }
    } catch (e) {
      throw Exception(
          'Failed to get coordinates for the provided city: ${e.toString()}');
    }
  }

  Future<WeatherData> fetchWeatherDataFor({required String city}) async {
    print('fetchWeatherDataFor $city');
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=e8e5f6f91a238065d8ba0123f65e95d5&units=metric'));

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
