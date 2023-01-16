import 'package:flutter/material.dart';
import 'package:weather/features/weather/presentation/weather_details/search_bar/search_bar.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_card.dart';
import 'package:weather/features/weather/presentation/weather_search/weather_search.dart';
import 'package:weather/features/weather/services/weather_service.dart';
import 'package:weather/resources/constants/app_constants.dart';

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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Positioned(
              top: defaultPadding * 1.5,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          WeatherSearch(),
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ),
                  );
                },
                child: const SearchBar(
                  enabled: false,
                ),
              ),
            ),
            Positioned(
              top: defaultPadding * 5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.872,
                height: 650,
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
            ),
          ],
        ),
      ),
    );
  }
}
