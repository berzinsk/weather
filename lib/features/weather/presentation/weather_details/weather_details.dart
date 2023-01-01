import 'package:flutter/material.dart';
import 'package:weather/features/weather/domain/weather.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_card.dart';
import 'package:weather/features/weather/services/weather_service.dart';

class WeatherDetails extends StatefulWidget {
  final WeatherService weatherService;

  const WeatherDetails({
    super.key,
    required this.weatherService,
  });

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  late Future<WeatherData> data;

  @override
  void initState() {
    super.initState();

    data = widget.weatherService.fetchWeatherData();
  }

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
            FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return WeatherCard(weatherData: snapshot.data!);
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
