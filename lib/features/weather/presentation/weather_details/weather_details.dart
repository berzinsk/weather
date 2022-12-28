import 'package:flutter/material.dart';
import 'package:weather/features/weather/domain/weather.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_card.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherData weatherData = WeatherData(
    id: 123,
    name: 'Dreiliņi',
    timezone: 7200,
    coord: Coord(
      lat: 56.9465,
      lon: 24.2475,
    ),
    weather: Weather(
      id: 803,
      main: 'Clouds',
      description: 'broken clouds',
      icon: '04d',
    ),
    main: Main(
      temp: 2.85,
      feelsLike: -0.52,
      tempMin: 2.14,
      tempMax: 3.01,
      humidity: 89,
    ),
    systemData: SystemData(
      id: 2075320,
      country: 'LV',
      sunrise: 1672210876,
      sunset: 1672235242,
    ),
  );

  WeatherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 46,
              color: Colors.grey,
              child: const Center(
                child: Text('Search placeholder'),
              ),
            ),
            WeatherCard(weatherData: weatherData),
          ],
        ),
      ),
    );
  }
}
