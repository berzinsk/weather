import 'package:flutter/material.dart';
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

  const WeatherDetails({
    super.key,
    required this.weatherService,
    required this.locationService,
    required this.storageService,
  });

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  List<WeatherDataType> data = [];

  @override
  void initState() {
    widget.locationService.requestLocationAccess();
    loadAvailableCities();
    super.initState();
  }

  Future<void> loadAvailableCities() async {
    var weatherDataTypes = <WeatherDataType>[];

    final shouldRenderLocation =
        await widget.storageService.getLocationStatus();

    if (shouldRenderLocation) {
      final userLocation = await widget.locationService.getCurrentPosition();
      weatherDataTypes.add(WeatherDataType(
        forCurrentLocation: true,
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      ));
    }

    final storedCities = await widget.storageService.getCities();
    final cities = storedCities.map(
      (e) => WeatherDataType(
        cityName: e,
        forCurrentLocation: false,
      ),
    );
    weatherDataTypes.addAll(cities);

    setState(() {
      data = weatherDataTypes;
    });
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
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.872,
                      child: WeatherCard(
                        data: data[index],
                        weatherService: widget.weatherService,
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
