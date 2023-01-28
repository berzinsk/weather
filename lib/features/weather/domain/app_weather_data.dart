import 'package:weather/features/weather/domain/uv_data.dart';
import 'package:weather/features/weather/domain/weather.dart';

class AppWeatherData {
  WeatherData? weatherData;
  UVData? uvData;
  bool isForLocation;
  String locationName;
  int cityId;

  AppWeatherData({
    required this.weatherData,
    required this.uvData,
    this.isForLocation = false,
    this.locationName = '',
    this.cityId = 0,
  });
}
