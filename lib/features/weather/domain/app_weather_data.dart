import 'package:weather/features/weather/domain/uv_data.dart';
import 'package:weather/features/weather/domain/weather.dart';

class AppWeatherData {
  final WeatherData weatherData;
  final UVData uvData;
  final bool isForLocation;

  AppWeatherData({
    required this.weatherData,
    required this.uvData,
    this.isForLocation = false,
  });
}
