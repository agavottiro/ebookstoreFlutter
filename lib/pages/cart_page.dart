import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_bar_widget.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EBookStoreBloc, EBookStoreState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.backgroundGreen,
          appBar: const AppBarWidget(
            title: "Cart",
            image: Svg("assets/icons/cart.svg"),
          ),
          body: Expanded(
              child: state.cart.isEmpty
                  ? Center(
                      child: Text(
                        "No books on the cart yet",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColor.green),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.cart.length,
                      itemBuilder: (context, index) {
                        final book = state.cart[index];
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<EBookStoreBloc>()
                                    .add(RemoveCartItemEvent(book: book));
                              },
                              child: Icon(
                                Icons.delete,
                                color: AppColor.red,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(book.imageUrl),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(book.title),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text((book.price * book.quantity)
                                          .toString()),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<EBookStoreBloc>()
                                                  .add(
                                                    UpdateCartQuantityEvent(
                                                      bookCart: book,
                                                      newQuantity:
                                                          book.quantity - 1,
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      AppColor.backgroundGreen),
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                    color: AppColor.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Text(book.quantity.toString()),
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<EBookStoreBloc>()
                                                  .add(
                                                    UpdateCartQuantityEvent(
                                                      bookCart: book,
                                                      newQuantity:
                                                          book.quantity + 1,
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      AppColor.backgroundGreen),
                                              child: Text(
                                                "+",
                                                style: TextStyle(
                                                    color: AppColor.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      })),
        );
      },
    );
  }
}
