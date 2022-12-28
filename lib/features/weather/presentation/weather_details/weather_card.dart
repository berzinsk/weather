import 'package:flutter/material.dart';
import 'package:weather/features/weather/domain/weather.dart';
import 'package:weather/features/weather/presentation/weather_details/current_time_row/current_time_row.dart';

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
                image: AssetImage('assets/images/current_location_icon.png'),
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
        const CurrentTimeRow(),
      ],
    );
  }
}
