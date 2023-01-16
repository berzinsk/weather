import 'package:flutter/material.dart';
import 'package:weather/resources/colors/colors.dart';
import 'package:weather/resources/constants/app_constants.dart';

class SearchItem extends StatelessWidget {
  final bool hasWarning;

  const SearchItem({
    super.key,
    this.hasWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mumbai',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '20',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 60),
                  ),
                  const Text(
                    '\u00b0',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 67,
                child: Image(
                  image: AssetImage(
                      'assets/images/current_weather_placeholder.png'),
                ),
              ),
            ],
          ),
          if (hasWarning)
            Row(
              children: [
                const Image(
                  image: AssetImage(
                    'assets/images/icon_warning.png',
                  ),
                ),
                const SizedBox(width: paddingSmall),
                Text(
                  'Warning',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.primaryYellow),
                ),
                const Spacer(),
                Text(
                  'Expecting Rainfall',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.primaryYellow),
                )
              ],
            ),
        ],
      ),
    );
  }
}
