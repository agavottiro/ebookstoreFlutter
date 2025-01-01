import 'package:ebook_store_ag/model/book_model.dart';
import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_bar_widget.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class BookDetailPage extends StatelessWidget {
  final BookModel book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundGreen,
      appBar: const AppBarWidget(
        title: "Book Detail",
        image: Svg("assets/icons/share.svg"),
      ),
      body: BlocBuilder<EBookStoreBloc, EBookStoreState>(
        builder: (context, state) {
          return Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: size.height * .35,
                    width: size.width * .45,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(book.imageUrl),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                SizedBox(
                  height: size.height * .13,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$ ${book.price.toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColor.darkPink,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            book.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            book.author,
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColor.green,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: Image(
                          image: const Svg("assets/icons/bookmark-circle.svg"),
                          color: AppColor.darkPink,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "Rating",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text("4.1",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13))
                      ],
                    ),
                    const Divider(),
                    const Column(
                      children: [
                        Text(
                          "Number of Pages",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text("120 pages",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13))
                      ],
                    ),
                    Divider(
                      color: AppColor.black,
                    ),
                    const Column(
                      children: [
                        Text(
                          "Language",
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          "ENG",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                SizedBox(
                  height: size.height * .10,
                  child: const Center(
                    child: Text(
                        "This is a very interesting book. Many have claimed this is one of the best books ever. Highly recommended if you are looking for a great adventure."),
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: size.width * .1,
                        height: 40,
                        child: const Center(
                            child: Text(
                          "QTY",
                          style: TextStyle(fontSize: 16),
                        ))),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.backgroundGreen),
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: AppColor.black, fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Text(
                          book.quantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.backgroundGreen),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: AppColor.black, fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<EBookStoreBloc>()
                            .add(AddToCardEvent(book: book));
                      },
                      child: Container(
                        width: size.width * .3,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColor.darkPink,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "Add to cart",
                          style: TextStyle(
                              color: AppColor.lightGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
