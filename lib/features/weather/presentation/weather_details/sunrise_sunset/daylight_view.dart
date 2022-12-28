import 'package:flutter/material.dart';
import 'package:weather/resources/colors/colors.dart';

class DaylightView extends StatelessWidget {
  final String label;
  final String time;

  const DaylightView({
    super.key,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: time,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
