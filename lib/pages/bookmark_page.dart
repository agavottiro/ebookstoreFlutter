import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/stars_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EBookStoreBloc>().add(LoadAllBooksEvent());
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Favorite books",
          style:
              TextStyle(color: AppColor.darkPink, fontWeight: FontWeight.w700),
        )),
        backgroundColor: AppColor.green,
      ),
      backgroundColor: AppColor.green,
      body: BlocBuilder<EBookStoreBloc, EBookStoreState>(
        builder: (context, state) {
          final favoriteBooks =
              state.allBooks.where((book) => book.isFavorite).toList();
          return favoriteBooks.isEmpty
              ? Center(
                  child: Text(
                    "No favorite books yet",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColor.darkPink),
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteBooks.length,
                  itemBuilder: (context, index) {
                    final book = favoriteBooks[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.lightGreen,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image(
                                    image: NetworkImage(book.imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        book.title,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text("by ${book.author}"),
                                      const SizedBox(height: 4),
                                      const StarsWidget()
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                BlocBuilder<EBookStoreBloc, EBookStoreState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<EBookStoreBloc>()
                                            .add(BookmarkEvent(book: book));
                                      },
                                      child: SizedBox(
                                        height: 45,
                                        width: 45,
                                        child: Image(
                                          image: const Svg(
                                              "assets/icons/bookmark-circle.svg"),
                                          color: book.isFavorite
                                              ? AppColor.darkPink
                                              : AppColor.lightGreen,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
