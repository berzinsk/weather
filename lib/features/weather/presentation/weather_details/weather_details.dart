import 'package:flutter/material.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_card.dart';
import 'package:weather/features/weather/services/weather_service.dart';

enum WeatherSearchType {
  current,
  dreilini,
}

class WeatherDetails extends StatelessWidget {
  final WeatherService weatherService;
  final List<WeatherSearchType> weatherTypes = [
    WeatherSearchType.current,
    WeatherSearchType.dreilini,
  ];

  WeatherDetails({
    super.key,
    required this.weatherService,
  });

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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.872,
              height: 550,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                itemCount: weatherTypes.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.872,
                    child: WeatherCard(
                      searchType: weatherTypes[index],
                      weatherService: weatherService,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
