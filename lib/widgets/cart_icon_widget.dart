import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/pages/cart_page.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EBookStoreBloc, EBookStoreState>(
      builder: (context, state) {
        final total = state.cart.fold(0, (sum, p) => sum + p.quantity);
        return GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage())),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image(
                image: Svg("assets/icons/bag.svg"),
                color: AppColor.darkPink,
                height: 30,
              ),
              Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.green),
                    width: 18,
                    height: 18,
                    child: Text(
                      total.toString(),
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
