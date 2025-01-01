import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_bar_widget.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/book_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MoreBooks extends StatelessWidget {
  const MoreBooks({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundGreen,
      appBar: const AppBarWidget(
        title: 'More books',
        image: Svg("assets/icons/more.svg"),
      ),
      body: Expanded(child: BlocBuilder<EBookStoreBloc, EBookStoreState>(
          builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: .48,
              ),
              itemCount: state.allBooks.length,
              itemBuilder: (context, index) {
                final book = state.allBooks[index];
                return BookGridWidget(
                  book: book,
                  height: size.height * .32,
                );
              }),
        );
      })),
    );
  }
}
