import 'package:flutter/material.dart';

class CurrentTimeRowItem extends StatelessWidget {
  final String title;
  final String data;

  const CurrentTimeRowItem({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
