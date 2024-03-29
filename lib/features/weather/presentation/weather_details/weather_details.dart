import 'package:flutter/material.dart';
import 'package:weather/features/weather/controllers/weather_controller.dart';
import 'package:weather/features/weather/domain/app_weather_data.dart';
import 'package:weather/features/weather/presentation/weather_details/search_bar/search_bar.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_card.dart';
import 'package:weather/features/weather/presentation/weather_search/weather_search.dart';
import 'package:weather/features/weather/services/location_service.dart';
import 'package:weather/features/weather/services/storage_service.dart';
import 'package:weather/features/weather/services/weather_service.dart';
import 'package:weather/resources/colors/colors.dart';
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
  List<AppWeatherData> weatherData = [];
  List<String> placeholderCityNames = [];

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    widget.weatherContrller.loadData().then((cities) {
      setState(() {
        weatherData = cities;
      });
    });

    widget.weatherContrller.streamController.stream.listen((event) {
      var currentData = weatherData;

      if (event.isForLocation) {
        event.locationName = event.weatherData?.name ?? '';
        currentData.insert(0, event);
      } else {
        var currentItemIndex = currentData
            .indexWhere((e) => e.locationName == event.weatherData?.name);

        var currentItem = currentData[currentItemIndex];
        currentItem.isForLocation = event.isForLocation;
        currentItem.uvData = event.uvData;
        currentItem.weatherData = event.weatherData;

        currentData[currentItemIndex] = currentItem;
      }

      setState(() {
        weatherData = currentData;
      });
    });

    widget.weatherContrller.fetchData();

    super.initState();
  }

  @override
  void dispose() {
    widget.weatherContrller.streamController.close();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
        child: Stack(
          alignment: Alignment.center,
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
              top: defaultPadding * 6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryBackground,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    weatherData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: _currentPage == index
                              ? AppColors.nightBlue
                              : AppColors.labelGray,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: defaultPadding * 7,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.872,
                height: 650,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  controller: _pageController,
                  pageSnapping: true,
                  itemCount: weatherData.length,
                  itemBuilder: (context, index) {
                    final item = weatherData[index];
                    return SizedBox(
                      key: Key(item.weatherData?.name ?? item.locationName),
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
