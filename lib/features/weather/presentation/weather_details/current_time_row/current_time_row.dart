import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/common_widgets/info_row.dart';
import 'package:weather/features/weather/domain/uv_data.dart';
import 'package:weather/features/weather/domain/weather.dart';
import 'package:weather/features/weather/presentation/weather_details/current_time_row/current_time_row_item.dart';

class CurrentTimeRow extends StatelessWidget {
  final WeatherData weatherData;
  final UVData uvData;

  const CurrentTimeRow({
    super.key,
    required this.weatherData,
    required this.uvData,
  });

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurrentTimeRowItem(
            title: 'Time',
            data: _showCurrentTime(),
          ),
          CurrentTimeRowItem(
            title: 'UV',
            data: '${uvData.value.toInt()}',
          ),
          CurrentTimeRowItem(
            title: '% Clouds',
            data: '${weatherData.clouds.all}',
          ),
          CurrentTimeRowItem(
            title: 'Wind m/s',
            data: '${weatherData.wind.speed}',
          ),
        ],
      ),
    );
  }

  String _showCurrentTime() {
    final dateFormat = DateFormat('HH:mm');
    return dateFormat.format(DateTime.now());
  }
}
