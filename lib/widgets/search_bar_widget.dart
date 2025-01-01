import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/widgets.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: size.height * .12,
        color: AppColor.darkPink,
      ),
    );
  }
}
