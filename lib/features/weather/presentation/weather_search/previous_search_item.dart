import 'package:flutter/material.dart';
import 'package:weather/resources/colors/colors.dart';
import 'package:weather/resources/constants/app_constants.dart';

class PreviousSearchItem extends StatelessWidget {
  final String title;

  const PreviousSearchItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: AppColors.primary),
      ),
    );
  }
}
