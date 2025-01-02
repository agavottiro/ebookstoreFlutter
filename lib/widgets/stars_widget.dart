import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      width: 100,
      child: Row(
        children: [
          Image(
            image: const Svg("assets/icons/star.svg"),
            color: AppColor.darkPink,
          ),
          Image(
            image: const Svg("assets/icons/star.svg"),
            color: AppColor.darkPink,
          ),
          Image(
            image: const Svg("assets/icons/star.svg"),
            color: AppColor.darkPink,
          ),
          Image(
            image: const Svg("assets/icons/star.svg"),
            color: AppColor.darkPink,
          ),
          Image(
            image: const Svg("assets/icons/star.svg"),
            color: AppColor.green,
          )
        ],
      ),
    );
  }
}
