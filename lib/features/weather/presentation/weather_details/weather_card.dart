import 'package:flutter/material.dart';
import 'package:weather/features/weather/domain/weather.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Image(
          image: AssetImage('assets/images/current_weather_placeholder.png'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weatherData.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 8),
            const Image(
              image: AssetImage('assets/images/current_location_icon.png'),
            ),
          ],
        )
      ],
    );
  }
}
