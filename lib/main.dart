import 'package:flutter/material.dart';
import 'package:weather/features/weather/presentation/weather_details/weather_details.dart';
import 'package:weather/features/weather/services/weather_service.dart';
import 'package:weather/resources/theme/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        textTheme: theme,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WeatherDetails(
            weatherService: WeatherService(),
          ),
        ),
      ),
    );
  }
}
