import 'package:ebook_store_ag/pages/admin_page.dart';
import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/pages/more_books.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/book_grid_widget.dart';
import 'package:ebook_store_ag/widgets/cart_icon_widget.dart';
import 'package:ebook_store_ag/widgets/continue_reading_widget.dart';
import 'package:ebook_store_ag/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EBookStoreBloc>()..add(LoadAllBooksEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EBookStoreBloc>().add(LoadCurrentlyReadingBookEvent());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundGreen,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPage())),
                  child: Image(
                    image: const Svg("assets/icons/admin.svg"),
                    color: AppColor.darkPink,
                    height: 35,
                  ),
                ),
                Row(
                  children: [
                    const CartIconWidget(),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        image: const DecorationImage(
                            image: AssetImage("assets/img/avatar.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SearchBarWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Trending books",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MoreBooks())),
                  child: const Text(
                    "See more",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: SizedBox(
              height: size.height * .40,
              child: BlocBuilder<EBookStoreBloc, EBookStoreState>(
                builder: (context, state) {
                  if (state.exploreScreenState == ExploreScreenState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.allBooks.isEmpty) {
                    return const Center(
                      child: Text("No books available"),
                    );
                  }
                  return SizedBox(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(left: 16),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final book = state.allBooks[index];
                          return BookGridWidget(
                            book: book,
                            height: size.height * .29,
                          );
                        }),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: AppColor.green,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Continue Reading",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor.backgroundGreen,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    BlocBuilder<EBookStoreBloc, EBookStoreState>(
                      builder: (context, state) {
                        return ContinueReadingWidget(
                            book: state.currentlyReadingBook);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
