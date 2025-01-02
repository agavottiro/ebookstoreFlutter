import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/cart_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool cartDisable;

  const AppBarWidget({
    super.key,
    required this.title,
    this.cartDisable = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.backgroundGreen,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image(
            image: const Svg("assets/icons/back.svg"),
            color: AppColor.darkPink,
          ),
        ),
      ),
      title: Center(
          child: Text(
        title,
        style: TextStyle(color: AppColor.darkPink, fontWeight: FontWeight.w600),
      )),
      actions: [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            child: cartDisable ? SizedBox.shrink() : CartIconWidget())
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
