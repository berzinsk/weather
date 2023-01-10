import 'package:flutter/material.dart';
import 'package:weather/resources/colors/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      width: MediaQuery.of(context).size.width - 48,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryBackground,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Location',
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Image(image: AssetImage('assets/images/icon_search.png'))
        ],
      ),
    );
  }
}
