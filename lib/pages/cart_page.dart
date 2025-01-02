import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_bar_widget.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/quantity_handler_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EBookStoreBloc>().add(LoadCartItemsEvent());
    return Scaffold(
        backgroundColor: AppColor.backgroundGreen,
        appBar: const AppBarWidget(
          title: "Cart",
          cartDisable: true,
        ),
        body: BlocBuilder<EBookStoreBloc, EBookStoreState>(
          builder: (context, state) {
            return state.cartScreenState == CartScreenState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.cart.isEmpty
                    ? Center(
                        child: Text(
                          "No books on the cart yet",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColor.green),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Total: \$${state.cart.fold<double>(0, (total, book) => total + (book.price * book.quantity)).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.darkPink),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.cart.length,
                                itemBuilder: (context, index) {
                                  final book = state.cart[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.read<EBookStoreBloc>().add(
                                                RemoveCartItemEvent(
                                                    book: book));
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: AppColor.red,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.network(book.imageUrl),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                book.title,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "By ${book.author}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColor.green,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      QuantityHandlerWidget(
                                                        initialQuantity:
                                                            book.quantity,
                                                        maxQuantity: 10,
                                                        onQuantityChanged:
                                                            (newQuantity) {
                                                          context
                                                              .read<
                                                                  EBookStoreBloc>()
                                                              .add(
                                                                UpdateCartQuantityEvent(
                                                                    bookCart:
                                                                        book,
                                                                    newQuantity:
                                                                        newQuantity),
                                                              );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    ("\$${book.price * book.quantity}")
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.darkPink),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<EBookStoreBloc>()
                                    .add(CheckoutEvent(books: state.cart));
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColor.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Checkout",
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ))),
                            ),
                          )
                        ],
                      );
          },
        ));
  }
}
