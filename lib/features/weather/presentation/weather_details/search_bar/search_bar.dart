import 'package:flutter/material.dart';
import 'package:weather/resources/colors/colors.dart';

class SearchBar extends StatefulWidget {
  final Function()? onSearchTap;
  final Function()? onClearTap;
  final bool autofocus;
  final bool enabled;

  const SearchBar({
    super.key,
    this.onSearchTap,
    this.onClearTap,
    this.autofocus = false,
    this.enabled = true,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool hasFocus = false;
  var focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              focusNode: focusNode,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              onTap: widget.onSearchTap,
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
          InkWell(
            onTap: widget.onClearTap,
            child: hasFocus
                ? Icon(
                    Icons.close,
                    color: AppColors.labelGray,
                  )
                : const Image(
                    image: AssetImage('assets/images/icon_search.png'),
                  ),
          ),
        ],
      ),
    );
  }
}
