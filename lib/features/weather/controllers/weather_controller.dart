import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:weather/features/weather/domain/app_weather_data.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_details.dart';
import 'package:weather/features/weather/services/location_service.dart';
import 'package:weather/features/weather/services/storage_service.dart';
import 'package:weather/features/weather/services/weather_service.dart';

class WeatherController {
  final StorageService storageService;
  final LocationService locationService;
  final WeatherService weatherService;

  StreamController<AppWeatherData> streamController =
      StreamController<AppWeatherData>();

  WeatherController({
    required this.storageService,
    required this.locationService,
    required this.weatherService,
  });

  Future<void> fetchData() async {
    var weatherDataTypes = <WeatherDataType>[];
    final shouldRenderLocation = await storageService.getLocationStatus();

    if (shouldRenderLocation) {
      final userLocation = await locationService.getCurrentPosition();

      if (userLocation != null) {
        weatherDataTypes.add(WeatherDataType(
          forCurrentLocation: true,
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
        ));
      } else {
        storageService.setLocationStatus(false);
      }
    } else {
      _requestUserPermission();
    }

    final storedCities = await storageService.getCities();
    final List<String> citiesToLoad;

    if (storedCities.isNotEmpty) {
      citiesToLoad = storedCities;
    } else {
      // TODO: Check with New York because there is some error in UI with that
      citiesToLoad = ['New York', 'Riga', 'Sydney'];
    }

    final cities = citiesToLoad.map(
      (e) => WeatherDataType(
        cityName: e,
        forCurrentLocation: false,
      ),
    );

    weatherDataTypes.addAll(cities);

    for (final type in weatherDataTypes) {
      if (type.forCurrentLocation) {
        final latitude = type.latitude.toString();
        final longitude = type.longitude.toString();

        final wData = await weatherService.fetchWeatherDataForLocation(
          latitude: latitude,
          longitude: longitude,
        );
        final uvData = await weatherService.fetchUvDataForLocation(
            latitude: latitude, longitude: longitude);

        final appWeatherData = AppWeatherData(
          weatherData: wData,
          uvData: uvData,
          isForLocation: true,
        );

        streamController.add(appWeatherData);
      } else {
        final wData =
            await weatherService.fetchWeatherDataFor(city: type.cityName ?? '');
        final uvData =
            await weatherService.fetchUvDataFor(city: type.cityName ?? '');

        final appWeatherData = AppWeatherData(
          weatherData: wData,
          uvData: uvData,
        );

        streamController.add(appWeatherData);
      }
    }
  }

  Future<void> _requestUserPermission() async {
    locationService.requestLocationAccess().then((value) async {
      final locationEnabled = value == LocationPermission.always ||
          value == LocationPermission.whileInUse;

      if (locationEnabled) {
        _loadWeatherForLocation();
      }
    });
  }

  Future<void> _loadWeatherForLocation() async {
    await storageService.setLocationStatus(true);

    final userLocation = await locationService.getCurrentPosition();

    if (userLocation == null) {
      return;
    }

    final latitude = userLocation.latitude.toString();
    final longitude = userLocation.longitude.toString();

    final wData = await weatherService.fetchWeatherDataForLocation(
      latitude: latitude,
      longitude: longitude,
    );
    final uvData = await weatherService.fetchUvDataForLocation(
        latitude: latitude, longitude: longitude);

    streamController.add(AppWeatherData(
      weatherData: wData,
      uvData: uvData,
      isForLocation: true,
    ));
  }
}
