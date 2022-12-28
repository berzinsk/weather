import 'package:flutter/material.dart';
import 'package:weather/common_widgets/info_row.dart';
import 'package:weather/features/weather/presentation/weather_details/current_time_row/current_time_row_item.dart';

class CurrentTimeRow extends StatelessWidget {
  const CurrentTimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          CurrentTimeRowItem(
            title: 'Time',
            data: '11:25',
          ),
          CurrentTimeRowItem(
            title: 'UV',
            data: '11:25',
          ),
          CurrentTimeRowItem(
            title: '% Rain',
            data: '11:25',
          ),
          CurrentTimeRowItem(
            title: 'AQ',
            data: '11:25',
          ),
        ],
      ),
    );
  }
}
