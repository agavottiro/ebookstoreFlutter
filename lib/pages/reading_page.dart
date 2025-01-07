import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/book_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EBookStoreBloc>().add(LoadPurchasedBooksEvent());
    context.read<EBookStoreBloc>().add(LoadCurrentlyReadingBookEvent());
    return BlocProvider.value(
        value: context.read<EBookStoreBloc>(), child: const ReadingBody());
  }
}

class ReadingBody extends StatelessWidget {
  const ReadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "My books",
          style:
              TextStyle(color: AppColor.darkPink, fontWeight: FontWeight.w700),
        )),
        backgroundColor: AppColor.green,
      ),
      backgroundColor: AppColor.green,
      body: BlocBuilder<EBookStoreBloc, EBookStoreState>(
        builder: (context, state) {
          return state.purchasedScreenState == PurchasedScreenState.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.purshasedBooks.isEmpty
                  ? Center(
                      child: Text(
                        "No books purchased yet",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColor.darkPink),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.purshasedBooks.length,
                      itemBuilder: (context, index) {
                        final book = state.purshasedBooks[index];
                        final isCurrentlyReading = state.currentlyReadingBooks
                            .any((b) => b.id == book.id);
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: BookListWidget(
                            book: book,
                            initialReadingState:
                                isCurrentlyReading ? 'Reading' : 'startReading',
                          ),
                        );
                      });
        },
      ),
    );
  }
}
