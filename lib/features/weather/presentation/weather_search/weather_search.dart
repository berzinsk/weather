import 'package:flutter/material.dart';
import 'package:weather/features/weather/presentation/weather_details/search_bar/search_bar.dart';
import 'package:weather/features/weather/presentation/weather_search/previous_search_item.dart';
import 'package:weather/features/weather/presentation/weather_search/search_item.dart';
import 'package:weather/resources/constants/app_constants.dart';

class WeatherSearch extends StatelessWidget {
  final List<String> previousSearches = ['Mumbai', 'Pune'];

  WeatherSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, 0),
          child: Column(
            children: [
              const SearchBar(autofocus: true),
              const SizedBox(height: defaultPadding),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 31,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      PreviousSearchItem(title: previousSearches[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: paddingSmall,
                  ),
                  itemCount: previousSearches.length,
                ),
              ),
              const SizedBox(height: defaultPadding),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      SearchItem(hasWarning: index == 1),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: defaultPadding),
                  itemCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
