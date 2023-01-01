import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/common_widgets/info_row.dart';
import 'package:weather/features/weather/domain/weather.dart';
import 'package:weather/features/weather/presentation/weather_details/current_time_row/current_time_row_item.dart';

class CurrentTimeRow extends StatelessWidget {
  final WeatherData data;

  const CurrentTimeRow({
    super.key,
    required this.data,
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
          const CurrentTimeRowItem(
            title: 'UV',
            data: '11:25',
          ),
          CurrentTimeRowItem(
            title: '% Clouds',
            data: '${data.clouds.all}',
          ),
          CurrentTimeRowItem(
            title: 'Wind m/s',
            data: '${data.wind.speed}',
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
