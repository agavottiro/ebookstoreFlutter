import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_bar_widget.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/book_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EBookStoreBloc>().add(LoadPurchasedBooksEvent());
    return Scaffold(
      appBar: const AppBarWidget(
        title: "My books",
        cartDisable: true,
      ),
      backgroundColor: AppColor.green,
      body: BlocBuilder<EBookStoreBloc, EBookStoreState>(
        builder: (context, state) {
          return state.purchasedScreenState == PurchasedScreenState.loading
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
                  : ListView.builder(
                      itemCount: state.purshasedBooks.length,
                      itemBuilder: (context, index) {
                        final book = state.purshasedBooks[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BookListWidget(
                              book: book, readingState: "Reading"),
                        );
                      });
        },
      ),
    );
  }
}
