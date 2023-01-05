import 'package:flutter/material.dart';
import 'package:weather/features/weather/domain/uv_data.dart';
import 'package:weather/features/weather/domain/weather.dart';
import 'package:weather/features/weather/presentation/weather_details/current_time_row/current_time_row.dart';
import 'package:weather/features/weather/presentation/weather_details/sunrise_sunset/sunrise_sunset_row.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_details.dart';
import 'package:weather/features/weather/services/weather_service.dart';

class WeatherCard extends StatefulWidget {
  final WeatherService weatherService;
  final WeatherSearchType searchType;

  const WeatherCard({
    super.key,
    required this.weatherService,
    required this.searchType,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  late Future<WeatherData> weatherData;
  late Future<UVData> uvData;

  @override
  void initState() {
    super.initState();

    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    if (widget.searchType == WeatherSearchType.current) {
      weatherData = widget.weatherService.fetchWeatherDataForLocation();
    } else {
      weatherData = widget.weatherService.fetchWeatherDataFor(city: 'Milan');
    }
    uvData = widget.weatherService.fetchUvData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([weatherData, uvData]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final weatherData = snapshot.data![0] as WeatherData;
          final uvData = snapshot.data![1] as UVData;

          return Column(
            children: [
              const SizedBox(height: 40),
              const Image(
                image:
                    AssetImage('assets/images/current_weather_placeholder.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weatherData.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 12),
                    const Image(
                      image:
                          AssetImage('assets/images/current_location_icon.png'),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weatherData.main.temp.toInt()} ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    '\u00b0',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              CurrentTimeRow(
                weatherData: weatherData,
                uvData: uvData,
              ),
              const SizedBox(height: 12),
              SunriseSunsetRow(
                systemData: weatherData.systemData,
              ),
            ],
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
