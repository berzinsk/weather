import 'package:flutter/material.dart';
import 'package:weather/resources/colors/colors.dart';

class InfoRow extends StatelessWidget {
  final Widget child;

  const InfoRow({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryBackground,
      ),
      child: child,
    );
  }
}
