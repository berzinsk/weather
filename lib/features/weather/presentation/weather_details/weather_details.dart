import 'package:flutter/material.dart';
import 'package:weather/features/weather/domain/uv_data.dart';
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
  late Future<WeatherData> weatherData;
  late Future<UVData> uvData;

  @override
  void initState() {
    super.initState();

    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    weatherData = widget.weatherService.fetchWeatherData();
    uvData = widget.weatherService.fetchUvData();
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
              future: Future.wait([weatherData, uvData]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final weatherData = snapshot.data![0] as WeatherData;
                  final uvData = snapshot.data![1] as UVData;

                  return WeatherCard(
                    weatherData: weatherData,
                    uvData: uvData,
                  );
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
