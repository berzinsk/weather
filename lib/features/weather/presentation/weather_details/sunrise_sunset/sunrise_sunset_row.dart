import 'package:flutter/material.dart';
import 'package:weather/common_widgets/info_row.dart';
import 'package:weather/features/weather/domain/weather.dart';
import 'package:weather/features/weather/presentation/weather_details/sunrise_sunset/daylight_view.dart';
import 'package:weather/resources/colors/colors.dart';

class SunriseSunsetRow extends StatelessWidget {
  final SystemData systemData;

  const SunriseSunsetRow({
    super.key,
    required this.systemData,
  });

  @override
  Widget build(BuildContext context) {
    return InfoRow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text(
              'SUNRISE & SUNSET',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          LayoutBuilder(builder: (builderContext, constraints) {
            final sunriseDate =
                DateTime.fromMillisecondsSinceEpoch(systemData.sunrise * 1000);
            final sunsetDate =
                DateTime.fromMillisecondsSinceEpoch(systemData.sunset * 1000);

            final sunriseInMinutes =
                (sunriseDate.hour * 60) + sunriseDate.minute;
            final sunsetInMinutes = (sunsetDate.hour * 60) + sunsetDate.minute;
            final dayInMinutes = sunsetInMinutes - sunriseInMinutes;

            final minuteSize = constraints.maxWidth / 1440;

            return Row(
              children: [
                Container(
                  width: minuteSize * sunriseInMinutes,
                  height: 10,
                  color: AppColors.nightBlue,
                ),
                Container(
                  width: minuteSize * dayInMinutes,
                  height: 10,
                  color: AppColors.dayBlue,
                ),
              ],
            );
          }),
          const SizedBox(height: 16),
          DaylightView(
            label: 'Length of day: ',
            time: _calculateDayLength(),
          ),
          DaylightView(
            label: 'Remaining daylight:: ',
            time: _calculateRemainingDaylight(),
          ),
        ],
      ),
    );
  }

  String _calculateDayLength() {
    final sunriseDate =
        DateTime.fromMillisecondsSinceEpoch(systemData.sunrise * 1000);
    final sunsetDate =
        DateTime.fromMillisecondsSinceEpoch(systemData.sunset * 1000);

    return _differenceBetweenDates(sunriseDate, sunsetDate);
  }

  String _calculateRemainingDaylight() {
    final sunsetDate =
        DateTime.fromMillisecondsSinceEpoch(systemData.sunset * 1000);
    final currentData = DateTime.now();

    return _differenceBetweenDates(currentData, sunsetDate);
  }

  String _differenceBetweenDates(DateTime startDate, DateTime endDate) {
    final minuteDifference = endDate.difference(startDate).inMinutes;

    final hour = minuteDifference ~/ 60;
    final minute = minuteDifference % 60;

    if (hour <= 0 && minute <= 0) {
      return '00H 00M';
    }

    return '${hour.toString().padLeft(2, '0')}H ${minute.toString().padLeft(2, '0')}M';
  }
}
