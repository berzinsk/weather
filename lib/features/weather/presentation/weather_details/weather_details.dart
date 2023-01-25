import 'package:flutter/material.dart';
import 'package:weather/features/weather/controllers/weather_controller.dart';
import 'package:weather/features/weather/domain/app_weather_data.dart';
import 'package:weather/features/weather/presentation/weather_details/search_bar/search_bar.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_card.dart';
import 'package:weather/features/weather/presentation/weather_search/weather_search.dart';
import 'package:weather/features/weather/services/location_service.dart';
import 'package:weather/features/weather/services/storage_service.dart';
import 'package:weather/features/weather/services/weather_service.dart';
import 'package:weather/resources/constants/app_constants.dart';

class WeatherDataType {
  final bool forCurrentLocation;
  final double? latitude;
  final double? longitude;
  final String? cityName;

  WeatherDataType({
    this.forCurrentLocation = false,
    this.latitude,
    this.longitude,
    this.cityName,
  });
}

class WeatherDetails extends StatefulWidget {
  final WeatherService weatherService;
  final LocationService locationService;
  final StorageService storageService;
  final WeatherController weatherContrller;

  const WeatherDetails({
    super.key,
    required this.weatherService,
    required this.locationService,
    required this.storageService,
    required this.weatherContrller,
  });

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  List<WeatherDataType> data = [];
  List<AppWeatherData> weatherData = [];

  @override
  void initState() {
    widget.weatherContrller.streamController.stream.listen((event) {
      var currentData = weatherData;
      if (event.isForLocation) {
        currentData.insert(0, event);
      } else {
        currentData.add(event);
      }

      setState(() {
        weatherData = currentData;
      });
    });

    widget.weatherContrller.fetchData();

    super.initState();
  }

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
                  itemCount: weatherData.length,
                  itemBuilder: (context, index) {
                    final item = weatherData[index];
                    return SizedBox(
                      key: Key(item.weatherData.name),
                      width: MediaQuery.of(context).size.width * 0.872,
                      child: WeatherCard(
                        data: item,
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
