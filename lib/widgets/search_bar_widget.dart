import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/widgets.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 80,
        color: AppColor.darkPink,
      ),
    );
  }
}
