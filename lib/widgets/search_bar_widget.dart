import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SearchBar(
        controller: _controller,
        leading: Icon(
          Icons.search,
          color: AppColor.green,
        ),
        hintText: "Search",
        enabled: false,
        backgroundColor: WidgetStateProperty.all(AppColor.lightPink),
      ),
    );
  }
}
